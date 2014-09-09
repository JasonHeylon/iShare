class ArticlesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :download_attached_file]
	before_action :add_read_count, only: :show
	before_action :only_self_or_admin_article, only: [:edit, :update, :destroy, :remove_attached_file]

	def index
		@tags = Article.tag_counts_on(:tags)
		@categories = Category.all

		# @articles = Article.includes(:user).paginate(page: params[:page], per_page: 10)
		@articles = Article.includes(:user).search(params[:keyword])
										 .paginate(page: params[:page], per_page: 20)
		@search_title = params[:keyword]
	end

	def show
		@related_articles = @article.find_related_tags.take(10)
		# remain = 10 - @related_articles.size
		# @related_articles.join(@article.categories.limit(remain))
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(article_params)
		# @article.attached_file = params[:article][:attached_file]
		if @article.save
			flash[:success] = "发布成功！"
			redirect_to @article
		else
			flash.now[:error] = "发布失败, 请检查表单!"
			render "new"
		end
	end

	def edit
		
	end

	def update
		if @article.update(article_params)
			flash[:success] = "更新成功!"
			redirect_to @article
		else
			flash.now[:error] = "更新失败!"
			render "edit"
		end

	end

	def destroy
		@article.destroy
		flash[:success] = "删除成功!"
		redirect_to articles_path
	end


	def download_attached_file
		@article = Article.find(params[:id])
		send_file @article.attached_file.current_path
		# render 'show'
	end

	def remove_attached_file
		@article = Article.find(params[:id])
		@article.remove_attached_file!
		@article.save
		flash[:success] = "已经删除附件！"
		redirect_to @article
	end




	private
		def article_params
			params.require(:article).permit(:title, :body, :tag_list, :category_id, :attached_file)
		end


		def add_read_count
			@article = Article.find(params[:id])
			@article.update(read_count: @article.read_count + 1)
		end

		def only_self_or_admin_article
			@article = Article.find(params[:id])
			redirect_to root_path  unless current_user && current_user == @article.user || current_user.is_admin?
		end



end
