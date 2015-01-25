class Subtag < ActiveRecord::Base
	
	belongs_to :tag 
	has_and_belongs_to_many :businesses
	
end
