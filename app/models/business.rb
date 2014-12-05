class Business < ActiveRecord::Base
	
	has_many :offers
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
end
