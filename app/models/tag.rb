class Tag < ActiveRecord::Base
	
	has_and_belongs_to_many :businesses

	scope :filter_by_name, lambda {|name| where(:name => name)}
end
