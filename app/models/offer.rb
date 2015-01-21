class Offer < ActiveRecord::Base

	belongs_to :business
	has_many :offer_dates
	has_many :user_offer_opinions
	has_many :users, :through => :user_offer_opinions
	
	validates_presence_of :percentage
	validates_associated :offer_dates

	scope :filter_by_percentage, lambda{|percentage| where(:percentage => percentage)}

	
end
