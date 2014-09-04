class ArticlesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :add_read_count, only: :show
	before_action :edit_only_my_article, only: [:edit, :update]

	def index
		@articles = Article.includes(:user).paginate(page: params[:page], per_page: 10)
		@tags = Article.tag_counts_on(:tags)
		@categories = Category.all
	end

	def show
		
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			flash[:success] = "发布成功！"
			redirect_to @article
		else
			flash.now[:error] = "发布失败!"
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




	private
		def article_params
			params.require(:article).permit(:title, :body, :tag_list)
		end

		def add_read_count
			@article = Article.find(params[:id])
			@article.update(read_count: @article.read_count + 1)
		end

		def edit_only_my_article
			@article = Article.find(params[:id])
			redirect_to root_path  unless current_user && current_user == @article.user
		end



end
