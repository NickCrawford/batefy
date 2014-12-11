class BusinessController < ApplicationController


	def sign_up
		@business = Business.new
	end

	def create
		params[:business][:latitude]= 3
		params[:business][:longitude]= 4
		@business = Business.new(business_params)
		if @business.save
			render("offers/index")
		else
			render("sign_up")
		end
	end

	private
		def business_params
				params.require(:business).permit(:name, :email, :password, :latitude, 
					:longitude, :country, :city, :state, :zip, :address, :phone, :website)
		end
end
