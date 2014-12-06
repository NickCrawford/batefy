class Offer < ActiveRecord::Base

	has_many :offer_dates
	belongs_to :business
	has_many :user_offer_opinions
	has_many :users, :through => :user_offer_opinions
	
	scope :filter_by_description, lambda{|description| where(:description => description)}

end
