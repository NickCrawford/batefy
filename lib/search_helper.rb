class SearchHelper

	attr_accessor :results

	@@businesses

	def initialize (businesses)
	 @@businesses = businesses
	end
	
	def filter_by_location(location)
		@@businesses << Business.near(location) unless location.blank?
	end

	def filter_by_tag(tag)
		tag = Tag.find_by_id(tag)
		@@businesses << tag.businesses unless tag.nil?
	end

	def filter_by_subtag(subtag)
		subtag = Subtag.find_by_id(subtag)
		@@businesses << subtag.businesses unless subtag.nil?
	end

	def filter_by_date(date)
		
	end

	def get_offers
		offers = []
		@@businesses = @@businesses.reduce {|memo,temp| memo & temp}
		@@businesses.each do |business|
      		offers << business.offers
      	end
      	offers.flatten!
    end

end
	

