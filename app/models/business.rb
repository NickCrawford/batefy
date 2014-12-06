class Business < ActiveRecord::Base

	
	has_many :offers
	has_and_belongs_to_many :tags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
	
	scope :filter_by_location, lambda {|latMax,latMin,lngMax,lngMin| 
		where("businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ?", latMax,latMin,lngMax,lngMin) 
	}
	
end
