class ArticlesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :add_read, only: :show

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
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
			flash[:error] = "发布失败!"
			render "new"
		end
	end




	private
		def article_params
			params.require(:article).permit(:title, :body)
		end

		def add_read
			
		end



end
