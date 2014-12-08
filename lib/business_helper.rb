class BusinessHelper

	attr_accessor :range, :tags, :businesses

	def initialize(range, tags=[])
		@range = range
		@tags = tags
		@businesses = []
		filterBusinesses	
	end

  	def filterBusinesses
  		filterByLocation
  		filterByTags
		@businesses.reduce {|array1, array2| array2.empty? ? array1 : array1 & array2}
		@businesses.flatten!.uniq!
	end

  	def filterByLocation
  		@businesses << (Business.filter_by_location range[:latMin], range[:latMax], range[:lngMin], range[:lngMax])
  	end

  	def filterByTags
  		@tags.each do |name|
			tags =Tag.filter_by_name name
			@businesses << tags.businesses
		end
  	end

end