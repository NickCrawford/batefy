class Business < ActiveRecord::Base

	has_secure_password
	has_attached_file :image,
					  :url => "/assets/images/business/profile/:id/:style/:basename.:extension",
					  :path => ":rails_root/public/assets/images/business/profile/:id/:style/:basename.:extension"

	has_many :offers
	has_and_belongs_to_many :tags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions
	

	attr_accessor :old_password, :new_password, :new_password_confirmation
	EMAIL_REGEX = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
	
	validates_presence_of :name
	validates_presence_of :email
	validates_length_of :email, {:maximum => 254}
	validates_format_of :email,  {:with => EMAIL_REGEX , :message => "is not valid"}
	validates_uniqueness_of :email, {:message => "already in use", :on => :create }
	validates_length_of :password, {:minimum => 8, :too_short => "must be at least 8 characters long", :on => :create }
	validates_confirmation_of :new_password
	validates_length_of :new_password, {:minimum=> 8, :too_short => "must be at least 8 characters long", :allow_blank => true }
	validate :examine_password, :on => :update
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip
	validates_presence_of :country
	validates :latitude, :presence => true
	validates :longitude, :presence => true

	private

		def examine_password
			if authenticate(@old_password)
				self.password = @new_password if password_changed? && errors.empty?
			else
				errors.add(:old_password, "Invalid. You must provide a valid password to update your profile")
			end
		end

		def password_changed?
			!@new_password.blank?
		end

	scope :filter_by_location, lambda {|latMax,latMin,lngMax,lngMin| 
		where("businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ?", latMax,latMin,lngMax,lngMin) 
	}
	scope :filter_by_name, lambda {|name| where(:name => name)}
end
