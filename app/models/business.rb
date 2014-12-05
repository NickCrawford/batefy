class Business < ActiveRecord::Base
	
	has_many :offers
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions

	def hello
	end

<<<<<<< HEAD
	def test
=======
	def testing
>>>>>>> 351bc6402b40ee57d586bead8a941bf06f66257f
	end
end
