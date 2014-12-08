class OfferHelper

	attr_accessor :location, :lat_lng_range, :tags, :percentage, :offers, :date

	def initialize(latitude, longitude, miles_range, date, tags=[], percentage = 0)
		@location = Coordinate.new latitude,longitude
    	@lat_lng_range =location.getCoordinatesRange miles_range
		@tags = tags
		@date = date
		@percentage = percentage
		@offers = []
		filterOffers	
	end

  	def filterOffers
  		filterByLocationAndTags
		filterByPercentage
		@offers.reduce {|array1, array2| array2.empty? ? array1 : array1 & array2}
		@offers.flatten!.uniq!
	end

  	def filterByLocationAndTags
  		bh = BusinessHelper.new(lat_lng_range,tags)
  		businesses = bh.businesses
  		@offers << business.offers
  	end

  	def filterByPercentage
  		@offers << (Offer.filter_by_percentage @percentage)
  	end

end