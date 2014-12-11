class BusinessController < ApplicationController

	def index
		#must include an offset and a limit that can be changed 
		#with show more. 
		@businesses = Business.all 
	end

	def sign_up
		@business = Business.new
	end

	def create
		params[:business][:latitude]= 3
		params[:business][:longitude]= 4
		@business = Business.new(business_params)
		if !@business.save
			render("sign_up")
		end
	end

	def profile
		@business = Business.find(params[:id])
	end

	def update
		@business = Business.find(params[:id])
		params[:business][:latitude]= 3
		params[:business][:longitude]= 4
		if !@business.update_attributes(business_params)
			render("profile")
		else
			redirect_to(:action => 'profile', :id => @business.id)
		end
	end

	private
		def business_params
				params.require(:business).permit(:name, :email, :password, :latitude, 
					:longitude, :country, :city, :state, :zip, :address, :phone, :website)
		end
end
