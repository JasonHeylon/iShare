class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :comments
	has_many :article_attachments

  validates :username, presence: true, length: {maximum: 50}
  
  before_save :downcase_email
 

  private
  	def downcase_email
  		self.email.downcase!
  	end

end
