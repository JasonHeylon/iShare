class Category < ActiveRecord::Base

	has_many :articles

	validates :name, presence: true, length: {maximum: 50}
	


end
