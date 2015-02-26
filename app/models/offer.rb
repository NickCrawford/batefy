class Offer < ActiveRecord::Base

	belongs_to :business
	has_many :offer_dates
	has_and_belongs_to_many :users
	
	validates_presence_of :percentage
	validates_associated :offer_dates

	scope :filter_by_percentage, lambda{|percentage| where(:percentage => percentage)}

	
end
