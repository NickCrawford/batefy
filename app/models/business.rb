class Business < ActiveRecord::Base
	
	has_many :offers
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions

	def hello
	end


	def testing2 
	end
	
	def test
	end
	
end
