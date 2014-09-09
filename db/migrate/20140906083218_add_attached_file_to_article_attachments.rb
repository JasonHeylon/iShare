class AddAttachedFileToArticleAttachments < ActiveRecord::Migration
  def change
    add_column :article_attachments, :attached_file, :string
  end
end
