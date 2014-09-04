class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }
  
  default_scope -> { order("created_at desc") }


  
end
