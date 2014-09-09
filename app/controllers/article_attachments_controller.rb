class ArticleAttachmentsController < ApplicationController

  # def new
  # 	@article = Article.find(params[:article_id])
  # 	@attachment = ArticleAttachment.new
  # end

  # def create
  # 	@article = Article.find(params[:article_id])
  # 	@attachment = @article.article_attachments.new(attachment_params)
  # 	@attachment.user = current_user
  # 	@attachment.save
  # 	flash[:success] = "文件上传成功！"
  # 	redirect_to @article
  # end

  def create
  	
  	
  end

  def destroy
    @attachment = ArticleAttachments.find(params[:id])
    @attachment.destroy
  end

  private
  	def attachment_params
  		params.require(:article_attachment).permit(:attached_file)
  		
  	end

end
