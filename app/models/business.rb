class Business < ActiveRecord::Base

		
	has_many :offers
	has_and_belongs_to_many :tags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
	
	validates_presence_of :name
	validates :email, :presence => true,
					  :length => {:maximum => 254},
					  :format => {:with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ , :message => "The format of your email doesn't look right."},
					  :uniqueness => {:case_sensitive => false, "Somebody already reagistered with this email. Did you forget your password?"}	
	validates :password, :presence => true,
					     :length => {:minimum => 8, :message => "Keep your business safe! Your password should be at least 8 characters long. Using numbers and simbols is highly suggested"}
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip
	validates_presence_of :country
	validates :latitude :presence => true,
						:numericality => {:message => "We could not find the specified address. Did you spell everything correctly?"}
	validates :longitude :presence => true,
						:numericality => {:message => "We could not find the specified address. Did you spell everything correctly?"}
	
	scope :filter_by_location, lambda {|latMax,latMin,lngMax,lngMin| 
		where("businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ?", latMax,latMin,lngMax,lngMin) 
	}
	
	scope :filter_by_name, lambda {|name| where(:name => name)}
	
end
