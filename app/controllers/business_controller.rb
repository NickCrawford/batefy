class BusinessController < ApplicationController

	def index
		#must include an offset and a limit that can be changed 
		#with show more. 
		@businesses = Business.all 
	end

	def log_in

	end

	def log_in_attempt
		if (business = Business.find_by_email(params[:email]))
			if business.authenticate(params[:password])
				flash[:notice] = "Successfully logged in"
				session[:id] = business.id
				redirect_to("profile") and return
			end
		end
		flash[:notice] = "Wrong email or password"
		render("log_in")
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
		@business = Business.find(session[:id])
	end

	def update
		@business = Business.find(params[:id])
		params[:business][:latitude]= 3
		params[:business][:longitude]= 4
		if @business.update_attributes(business_params)
			redirect_to(:action => 'profile', :id => @business.id) and return
		end
		render("profile")
	end

	private
		def business_params
				params.require(:business).permit(:name, :email, :password, :latitude, 
					:longitude, :country, :city, :state, :zip, :address, :phone, :website, 
					:new_password, :new_password_confirmation, :old_password)
		end
end
