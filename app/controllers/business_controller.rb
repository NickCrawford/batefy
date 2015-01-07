class BusinessController < ApplicationController

	def index
		#must include an offset and a limit that can be changed 
		#with show more. 
		@businesses = Business.all 
	end

	def sign_in
		
	end

	def sign_out
		session.clear
		redirect_to(:action => "sign_in")
	end

	def sign_in_attempt
		if (business = Business.find_by_email(params[:business][:email]))
			if business.authenticate(params[:business][:password])
				flash[:notice] = "Successfully logged in"
				session[:id] = business.id
				redirect_to(:action => "profile", :id => session[:id]) and return
			end
		end
		flash[:notice] = "Wrong email or password"
		render("sign_in")
	end

	def sign_up
		@business = Business.new
	end

	def create
		#params[:business][:latitude]= 3
		#params[:business][:longitude]= 4

		if params.blank?
			redirect_to(:action=>"sign_up")
		end
		@business = Business.new(business_params)
			if !@business.save
				render("sign_up")
			end
		session[:id] = @business.id
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
					:longitude, :country, :city, :state, :zip, :address, :image, :phone, :website, 
					:new_password, :new_password_confirmation, :old_password)
		end
end
