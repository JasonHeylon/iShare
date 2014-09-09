class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :article_attachments
  mount_uploader :attached_file, ArticleAttachedFileUploader

  accepts_nested_attributes_for :article_attachments, allow_destroy: true

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 5 }
  
  default_scope -> { order("created_at desc") }
  scope :search, ->(keyword){ where("title like ?", "%#{keyword}%") if keyword.present? }


  acts_as_taggable
  acts_as_commentable



  
end
