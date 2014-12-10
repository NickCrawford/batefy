class User < ActiveRecord::Base

	has_many :user_business_opinions
	has_many :user_offer_opinions

	has_many :businesses, :through => :user_business_opinions
	has_many :offers, :through => :user_offer_opinions

	validates_presence_of :email
	validates_presence_of :password
	validates_length_of :password, {:minimum => 6, :message => "Keep your account safe! Your password should be at least 6 characters long."}
	validates_inclusion_of :gender, {:in => ["M","F","O"]}

	scope :filter_by_email, lambda{|email| where(:email => email)}
	scope :filter_by_name, lambda{|name| where(:name => name)}
	scope :order_by_name, lambda{ order('name ASC')}
end
