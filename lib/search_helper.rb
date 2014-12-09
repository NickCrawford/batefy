class SearchHelper

	attr_accessor :results

	@@query_elements = {}

	def filterByLocation(latitude, longitude, range)
		@range = Coordinate.getLatLngRange(latitude,longitude,range)
		@@query_elements[:location] = {}
		@@query_elements[:location][:string] = " businesses.latitude BETWEEN ? AND ? AND businesses.longitude BETWEEN ? AND ? "
		@@query_elements[:location][:attributes] = [@range[:latMin], @range[:latMax], @range[:lngMin], @range[:lngMax]]
	end

	def filterByTags(tags)
		@@query_elements[:tags] = {}
		@@query_elements[:tags][:string] = ""
		@@query_elements[:tags][:attributes] = []
		tags.each do |name|
			@@query_elements[:tags][:string] = @@query_elements[:tags][:string] == "" ? "" : @@query_elements[:tags][:string] += "OR"
			@@query_elements[:tags][:string] +=  " tags.name = ? "
			@@query_elements[:tags][:attributes] << name
		end
	end

	def filterByDate(date)
		@@query_elements[:date] = {}
		@@query_elements[:date][:string] = " offer_date.date > ? "
		@@query_elements[:date][:attributes] = [date]
	end

	def filterByPercentage(percentage)
		@@query_elements[:date] = {}
		@@query_elements[:date][:string] = " offer.percentage = ? "
		@@query_elements[:date][:attributes] = [percentage]
	end

	def run
		string_query_statement, array_query_attributes=createQueryConditions
		conditions = [string_query_statement] + array_query_attributes.flatten!
		Business.joins(:offers).all.where(conditions)
	end

	def createQueryConditions
		string_query_statement=""
		array_query_attributes=[]
		@@query_elements.each do |element|
			string_query_statement = string_query_statement == "" ? "" : string_query_statement += "AND"
			string_query_statement += element[1][:string]
			array_query_attributes << element[1][:attributes]
		end
		[string_query_statement,array_query_attributes]
	end

end