class UserController < ApplicationController

 
  layout "application"
  
  require_dependency "../../lib/search_helper.rb"

  before_filter :require_log_in, :only => [:profile, :sign_out, :profile_update, :my_offers, :get_offer, :delete_offer]
  before_filter :require_parameters, :only => [:sign_up_attempt, :profile_update, :sign_in_attempt]

  def sign_up_attempt
  	@user = User.new(user_params)
    if @user.save
     flash[:notice] = "Account successfully created"
     render("/sign_in_out/sign_in")
   else
     render("sign_up")
   end
 end

def profile
  @user = User.find(session[:user_id])
  @latitude = request.location.latitude.to_s
  @longitude = request.location.longitude.to_s
end

def profile_update
 @user = User.find(session[:user_id])
 if @user.update_attributes(user_params)
  flash[:notice]="Account successfully updated"
  redirect_to(:action => 'profile', :id => @user.id) and return
end
render("profile")
end

def my_offers
 @user = User.find(session[:user_id])
 @offers = @user.offers
 search = SearchHelper.new
 @offers=search.filter_by_date(@offers)
end

def show_offer
  @latitude = params[:latitude]
  @longitude = params[:longitude]
end

def save_offer
 user = User.find(session[:user_id])
 offer = Offer.find_by_id(params[:offer_id])
 user.offers << offer
 render :nothing => true
end

def unsave_offer
  user = User.find(session[:user_id])
  offer = Offer.find_by_id(params[:offer_id])
  user.offers.delete(offer)
  render :nothing => true
end

private

def user_params
  params.require(:user).permit(:name,:email,:password,:birthday,:gender,:latitude_current, 
   :longitude_current, :country, :city, :state, :zip, :address, :image, :phone, :website, 
   :new_password, :new_password_confirmation, :old_password)
end

def require_log_in
  if !view_context.is_user_signed_in
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
