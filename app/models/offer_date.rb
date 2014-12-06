class OfferDate < ActiveRecord::Base
	belongs_to :offer

	scope :filter_by_date, lambda {|date| where('offer_dates.date > ?', date)}
end
