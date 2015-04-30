class BusinessController < ApplicationController


	layout "application"

	before_filter :require_log_in, :only => [:profile, :sign_out, :profile_update]
	before_filter :require_not_log_in, :only => [:sign_up]
	before_filter :require_parameters, :only => [:sign_up_attempt, :profile_update, :forgot_password_attempt]


	def index
		#must include an offset and a limit that can be changed 
		#with show more. 
		@businesses = Business.all
	end

	def sign_up_attempt
		@business = Business.new(business_params)
		if @business.save
			@tag = Tag.find(params[:business][:tags])
			@tag.businesses << @business
			@subtag = Subtag.find(params[:business][:subtags])
			@subtag.businesses << @business
			flash[:notice] = "Account successfully created"
			session[:business_id] = @business.id
			redirect_to(action: "profile") and return
		end
		@current_tag = params[:business][:tags]
		@current_subtag = params[:business][:subtags]
		render("sign_up")
	end

	def profile
		@business = Business.find(session[:business_id])
	end

	def profile_update
		@business = Business.find(session[:business_id])
		if @business.update_attributes(business_params)
			redirect_to(:action => 'profile', :id => @business.id) and return
		end
		render("profile")
	end

	def show
		@business = Business.find(params[:id])
	end

	private

		def business_params
				params.require(:business).permit(:name, :email, :description,
				 :country, :city, :state, :zip, :address, :image, :phone, :website, :promoter_code, :new_password, :new_password_confirmation,
					:password, :password_confirmation, :old_password, :forgot_password_token, :terms)
		end

		def require_log_in
			if !view_context.is_business_signed_in
				redirect_to("/sign_in_out/sign_in")
			end
		end

		def require_not_log_in
			if view_context.is_business_signed_in || view_context.is_user_signed_in 
				redirect_to("/")
			end
		end

		def require_parameters
			params.delete(:action)
			params.delete(:controller)
			redirect_to("/") if params.blank?
		end
end
