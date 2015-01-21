class OfferDate < ActiveRecord::Base

	belongs_to :offer

	validates_presence_of :start_time
	validates_presence_of :end_time
	validates_presence_of :visible_from
end
