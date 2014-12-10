class UserOfferOpinion < ActiveRecord::Base

	belongs_to :user
	belongs_to :offer

	validates_presence_of :opinion

end
