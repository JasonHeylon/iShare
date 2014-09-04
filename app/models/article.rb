class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }
  
  default_scope -> { order("created_at desc") }


  acts_as_taggable
  acts_as_commentable


  
end
