class OfferDate < ActiveRecord::Base
	belongs_to :offer

	validates_presence_of :date
	validates_presence_of :time_start
	validates_presence_of :time_end

	scope :filter_by_date, lambda {|date| where('offer_dates.date > ?', date)}
end
