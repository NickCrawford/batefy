class Offer < ActiveRecord::Base

	belongs_to :business
	has_many :user_offer_opinions
	has_many :users, :through => :user_offer_opinions
	
end
