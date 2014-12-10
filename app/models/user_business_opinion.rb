class UserBusinessOpinion < ActiveRecord::Base
	
	belongs_to :business
	belongs_to :user

	validates_presence_of :opinion
	validates_inclusion_of :opinion, {:in => [0,1]}

end
