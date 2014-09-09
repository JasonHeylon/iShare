class ArticleAttachment < ActiveRecord::Base
	include Rails.application.routes.url_helpers


  belongs_to :user
  belongs_to :article
  mount_uploader :attached_file, ArticleAttachmentUploader


   def to_jq_upload
    {
      "name" => read_attribute(:attached_file),
      "size" => attached_file.size,
      "url" => attached_file.url,
      "delete_url" => article_attachments_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end

end
