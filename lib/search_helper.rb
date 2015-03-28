class SearchHelper

	attr_accessor :results

	@@businesses

	def initialize (businesses=nil)
		@@businesses = businesses
	end
	
	def filter_by_location(location)
		location = location.blank? ? "milano" : location
		@@businesses << Business.near(location)
	end

	def filter_by_tag(tag)
		tag = Tag.find_by_id(tag)
		@@businesses << tag.businesses unless tag.nil?
	end

	def filter_by_subtag(subtag)
		subtag = Subtag.find_by_id(subtag)
		@@businesses << subtag.businesses unless subtag.nil?
	end

	def get_offers
		offers = []
		@@businesses = @@businesses.reduce {|memo,temp| memo & temp}
		@@businesses.each do |business|
			offers << business.offers
		end
		offers.flatten!
		offers = filter_by_date(offers)
	end

	def filter_by_date(offers)
		now = Time.now.in_time_zone("Rome").to_i
		filtered_offers = []
		offers.each do |offer|
			date = offer.offer_dates.last
			active_from = Time.at(date.visible_from).in_time_zone("Rome").to_i
			end_time = Time.at(date.end_time).in_time_zone("Rome").to_i
			unless (now>end_time || now < active_from) 
				filtered_offers << offer
			end
		end
		filtered_offers
	end

end


