class Business < ActiveRecord::Base

		
	has_many :offers
	has_and_belongs_to_many :tags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
	
	validates_presence_of :name
	validates_presence_of :email
	validates_presence_of :password
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip
	validates_presence_of :country
	validates_presence_of :latitude
	validates_presence_of :longitude

	scope :filter_by_location, lambda {|latMax,latMin,lngMax,lngMin| 
		where("businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ?", latMax,latMin,lngMax,lngMin) 
	}
	
	scope :filter_by_name, lambda {|name| where(:name => name)}
	
end
