class User < ActiveRecord::Base

	has_many :user_business_opinions
	has_many :user_offer_opinions

	has_many :businesses, :through => :user_business_opinions
	has_many :offers, :through => :user_offer_opinions
end
