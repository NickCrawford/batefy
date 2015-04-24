class Business < ActiveRecord::Base

	has_many :offers
	has_and_belongs_to_many :tags
	has_and_belongs_to_many :subtags
	has_many :user_business_opinions
	has_many :users, :through => :user_business_opinions

	attr_accessor :old_password, :new_password, :new_password_confirmation, :terms
	EMAIL_REGEX = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/

	has_secure_password
	geocoded_by :full_address
	has_attached_file :image,
					  :url => "/assets/images/business/profile/:id/:style/:basename.:extension",
					  :path => ":rails_root/public/assets/images/business/profile/:id/:style/:basename.:extension"
	
	before_validation :geocode, :if => ->(){(self.changed & ["address", "zip", "state", "country"]).any?}

	validates_presence_of :name
	validates_presence_of :email
	validates_length_of :email, {:maximum => 254}
	validates_format_of :email,  {:with => EMAIL_REGEX , :message => "is not valid"}
	validate :email_uniqueness, :on => :create
	validates_length_of :password, {:minimum => 8, :too_short => "must be at least 8 characters long", :on => :create }
	validates_length_of :new_password, {:minimum=> 8, :too_short => "must be at least 8 characters long", :allow_blank => true, :on => :update }
	validates_confirmation_of :new_password, :on => :update
	validate :examine_password, :on => :update
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip
	validates_presence_of :country
	validates_attachment_presence :image, :on => :create
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg','image/pjpeg','image/gif','image/png','image/webp']
	validate :lat_changed?, :if => ->(){(self.changed & ["address", "zip", "state", "country"]).any?}
	validates :terms, :acceptance => true

	private

		def examine_password
			return true if forgot_password_token_changed?
			if authenticate(@old_password)
				self.password = @new_password if password_changed? && errors.empty?
			else
				errors.add(:old_password, "invalid. You must provide a valid password to update your profile")
			end
		end

		def password_changed?
			!@new_password.blank?
		end

		def full_address
			if self.country == "United States"
				[self.address, self.city, self.state, self.country].join(' ,')
			else
				[self.address, self.city, self.country].join(' ,')
			end
		end

		def lat_changed?
        	if !(self.latitude_changed?)
            	self.errors.add(:address, "is not valid")
        	end
		end

		def email_uniqueness
			if (User.find_by_email(self.email) or Business.find_by_email(self.email))
				errors.add(:email, "already in use.")
			end
		end
end
