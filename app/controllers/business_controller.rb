class BusinessController < ApplicationController


	layout "application"

	before_filter :clear_flash, :only=> [:sign_up_attempt,:sign_in_attempt,:profile_update]
	before_filter :require_log_in, :only => [:profile, :sign_out, :profile_update] 
<<<<<<< HEAD
	before_filter :require_not_log_in, :only => [:sign_up,:sign_in, :show, :forgot_password, :forgot_password_attempt, :change_password, :change_password_attempt]
	before_filter :require_parameters, :only => [:sign_up_attempt, :profile_update, :sign_in_attempt, :forgot_password_attempt, :change_password, :change_password_attempt]
=======
	before_filter :require_not_log_in, :only => [:sign_up,:sign_in, :forgot_password, :forgot_password_attempt, :change_password, :change_password_attempt]
	before_filter :require_parameters, :only => [:sign_up_attempt, :profile_update, :sign_in_attempt, :forgot_password, :forgot_password_attempt, :change_password, :change_password_attempt]
>>>>>>> 2e8ef8748cc9afc3f0d54c9b02af5824e5a39ba8

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
		if business = Business.find_by_email(params[:business][:email])
			if business.authenticate(params[:business][:password])
				session[:business_id] = business.id
				redirect_to(:action => "profile") and return
			end
		end
		flash[:error] = "Wrong email or password"
		render("sign_in")
	end

	def sign_up
		@business = Business.new
	end

	def sign_up_attempt
		@business = Business.new(business_params)
		if @business.save
			@tag = Tag.find(params[:business][:tags])
			@tag.businesses << @business
			@subtag = Subtag.find(params[:business][:subtags])
			@subtag.businesses << @business
			flash[:notice] = "Account successfully created"
			render("sign_in")
		else
			render("sign_up")
		end
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

	def forgot_password
	end

	def forgot_password_attempt
		if (business=Business.find_by_email(params[:email]))
			business.update_attributes({forgot_password_token: @token = Digest::SHA1.hexdigest([Time.now, rand].join)})
			flash[:notice] = "Check your email for further instructions"
		else
			flash[:error] = "No Business with this email was found"
		end
		render("forgot_password")
	end

	def change_password
		@token = params[:token]
		unless (business = Business.find_by_forgot_password_token(@token))
			flash[:error] = "The link provided is invalid or has already expired"
		end
	end

	def change_password_attempt
		business = Business.find_by_forgot_password_token(@token) 
		if (business.update_attributes(forgot_password_token: "", new_password: params[:new_password], 
			new_password_confirmation: params[:new_password_confirmation]))
			flash[:notice] = "Password successfully updated"
			redirect_to("sign_in")
		end
		render("change_password")
	end

	private

		def business_params
				params.require(:business).permit(:name, :email, :password,
				 :country, :city, :state, :zip, :address, :image, :phone, :website, :promoter_code, 
					:new_password, :new_password_confirmation, :old_password, :forgot_password_token)
		end

		def require_log_in
			if !view_context.is_business_signed_in
				redirect_to(:action => "sign_in")
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

		def clear_flash
			flash.clear
		end
end
