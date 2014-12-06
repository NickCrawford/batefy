class Coordinate

	attr_accessor :latitude
	attr_accessor :longitude

	def initialize(latitude, longitude)
		 self.latitude = latitude
		 self.longitude = longitude
	end
	
	def getCoordinatesRange(range_of_search)
		earth_radius=3960.0
		degrees_to_radians=Math::PI/180.0
		radians_to_degrees=180.0/Math::PI
		r= earth_radius*(Math.cos(@latitude*degrees_to_radians))
		longRange=(range_of_search/r)*radians_to_degrees
		latRange=(range_of_search/earth_radius)*radians_to_degrees
		return {:latMin => @latitude-latRange,:latMax => @latitude+latRange,:lngMin => @longitude-longRange,:lngMax =>@longitude+longRange}
	end

end






