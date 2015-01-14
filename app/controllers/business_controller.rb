class BusinessController < ApplicationController

	layout "application"

	before_filter :require_log_in, :only => [:profile, :sign_out, :update, :create] 
	before_filter :require_not_log_in, :only => [:sign_up,:sign_in]
	before_filter :require_parameters, :only => [:create, :update, :sign_in_attempt]

	def index
		#must include an offset and a limit that can be changed 
		#with show more. 
		@businesses = Business.all
	end

	def sign_out
		session.clear
		redirect_to(:action => "sign_in")
	end

	def sign_in
	end

	def sign_in_attempt
		if (business = Business.find_by_email(params[:business][:email]))
			if business.authenticate(params[:business][:password])
				flash[:notice] = "Successfully logged in"
				session[:id] = business.id
				redirect_to(:action => "profile") and return
			end
		end
		flash[:notice] = "Wrong email or password"
		render("sign_in")
	end

	def sign_up
		@business = Business.new
	end

	def create
		@business = Business.new(business_params)
		if !@business.save
			render("sign_up")
		end
	end

	def profile
		@business = Business.find(session[:id])
	end

	def update
		@business = Business.find(session[:id])
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

		def require_log_in
			if !view_context.is_user_signed_in
				redirect_to(:action => "sign_in")
			end
		end

		def require_not_log_in
			if view_context.is_user_signed_in
				redirect_to(:action => "profile")
			end
		end

		def require_parameters
			params.delete(:action)
			params.delete(:controller)
			redirect_to(:action => "sign_in") if params.blank?
		end
end
