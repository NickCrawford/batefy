class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_offers_from_businesses(businesses)
  	offers=[]
  	businesses.each do |business|
  		offers << business.offers
  	end
  	offers.flatten!
  end
end
