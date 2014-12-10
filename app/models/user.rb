class User < ActiveRecord::Base

	has_many :user_business_opinions
	has_many :user_offer_opinions

	has_many :businesses, :through => :user_business_opinions
	has_many :offers, :through => :user_offer_opinions

	validates :email, :presence => true,
					  :length => {:maximum => 254},
					  :format => {:with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ , :message => "The format of your email doesn't look right."},
					  :uniqueness => {:case_sensitive => false, "Somebody already reagistered with this email. Did you forget your password?"}	
	validates :password, :presence => true,
					     :length => {:minimum => 6, :message => "Keep your account safe! Your password should be at least 6 characters long."}			
	validates_inclusion_of :gender, {:in => ["M","F","O"], :allow_blank => true, :allow_nil => true}

	scope :filter_by_email, lambda{|email| where(:email => email)}
	scope :filter_by_name, lambda{|name| where(:name => name)}
	scope :order_by_name, lambda{ order('name ASC')}
end
