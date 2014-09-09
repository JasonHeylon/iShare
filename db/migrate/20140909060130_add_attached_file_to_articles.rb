class AddAttachedFileToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :attached_file, :string
  end
end
