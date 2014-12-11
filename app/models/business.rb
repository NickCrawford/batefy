class Business < ActiveRecord::Base

		
	has_many :offers
	has_and_belongs_to_many :tags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
	

	attr_accessor :new_password, :new_password_confirmation

	validates_presence_of :name
	validates_presence_of :email
	validates_length_of :email, {:maximum => 254}
	validates_format_of :email,  {:with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ , :message => "is not valid"}
	validates_uniqueness_of :email, {:message => "already in use", :on => :create } 
	validates_presence_of :password
	validates_length_of :password, {:minimum => 8, :too_short => "must be at least 8 characters long"}
	validates_confirmation_of :password
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip
	validates_presence_of :country
	validates :latitude, :presence => true
	validates :longitude, :presence => true
	
	before_create :hash_password
	before_update :hash_password, :if => :password_changed?

	def password_changed?
		!@new_password.blank?
	end

	scope :filter_by_location, lambda {|latMax,latMin,lngMax,lngMin| 
		where("businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ?", latMax,latMin,lngMax,lngMin) 
	}
	scope :filter_by_name, lambda {|name| where(:name => name)}

	private
		
		def hash_password
			password = @new_password || self.password
			self.password = BCrypt::Password.create(password)
		end
end
