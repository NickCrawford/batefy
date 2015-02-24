class SearchHelper

	attr_accessor :results

	@@businesses

	def initialize (businesses)
	 @@businesses = businesses
	end
	
	def filter_by_location(location)
		location = location.blank? ? request.location.city : location
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
    	now = Time.now.to_i
    	filtered_offers = []
		offers.each do |offer|
			date = offer.offer_dates.last
			active_from = Time.at(date.visible_from).to_i
			end_time = Time.at(date.end_time).to_i
			unless (now>end_time) 
				filtered_offers << offer
			end
		end
		filtered_offers
	end

end
	

