class CommentsController < ApplicationController

	before_action :authenticate_user!
  before_action :only_self_or_admin_comment, only: [:edit, :update, :destroy]

  def create
  	@article = Article.find(params[:article_id])
  	@comment = @article.comment_threads.new(comment_params)
  	@comment.user = current_user
  	if @comment.save
  			flash[:success] = "回复成功！"
  			redirect_to @article
  		else
  			flash[:error] = "回复失败！"
  			redirect_to @article
  	end
  end


  def edit
  	
  	# @comment = @article.comment_threads.find(params[:id])
  end

  def update
  	# @article = Article.find(params[:article_id])
  	# @comment = @article.comment_threads.find(params[:id])
  	
  	if @comment.update(comment_params)
  		flash[:success] = "更新成功！"
  		redirect_to @article
  	else
  		flash.now[:error] = "更新失败！"
  		render 'edit'
  	end

  end

  def destroy
  	# @article = Article.find(params[:article_id])
  	# @comment = @article.comment_threads.find(params[:id])
  	if @comment.destroy
  		flash[:success] = "删除成功！"
  		redirect_to @article
		else
			flash[:error] = "删除失败！"
			redirect_to @article
  	end

  end


  private
  	def comment_params
  		params.require(:comment).permit(:body)
  	end

    def only_self_or_admin_comment
      @article = Article.find(params[:article_id])
      @comment = @article.comment_threads.find(params[:id])
      redirect_to articles_path unless current_user == @comment.user || current_user.is_admin?
    end

end
