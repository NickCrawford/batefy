class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"
  require_dependency "../../lib/coordinate.rb"

  layout 'application'

  before_filter :require_log_in, :only => [:new,:create,:edit,:update,:delete]
  before_filter :require_parameters, :only => [:edit, :update, :delete, :create]
  before_filter :require_offer_ownership, :only => [:edit,:update,:delete]

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    sh.filterByPercentage(10)
    sh.filterByLocation(1,4,1000)
    @businesses = sh.run
  end

  def show
    sh = SearchHelper.new
    @businesses = sh.run
  end

  def manage
    @business = Business.find(session[:id])
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      @business = Business.find(session[:id])
      @business.offers << @offer
      @offer_date = OfferDate.new(offer_date_params)
      @offer.offer_dates << @offer_date
    else
      @message="An error occurred while activating the offer"
    end
  end

  def update
    if @offer.save
      @message="Offer successfully activated"
    else
      @message="An error occurred while activating the offer"
    end
  end

  def delete
    @offer.destroy
  end

  private

    def offer_params
      params.require(:offer).permit(:percentage)
    end

    def offer_date_params
      set_time_attributes_from_params 
      params.require(:offer).permit(:start_time,:end_time,:active_from)
    end

    def set_time_attributes_from_params
      year = params[:offer][:year].to_i
      month = params[:offer][:month].to_i
      day = params[:offer][:day].to_i
      start_hour = params[:offer]['time_start(4i)'].to_i
      start_minute = params[:offer]['time_start(5i)'].to_i
      end_hour = params[:offer]['time_end(4i)'].to_i
      end_minute = params[:offer]['time_end(5i)'].to_i
      params[:offer][:start_time] = Time.new(year,month,day,start_hour,start_minute).to_i
      params[:offer][:end_time] = Time.new(year,month,day,end_hour,end_minute).to_i
      params[:offer][:active_from] = Time.new(year,month,day,start_hour,start_minute).to_i
    end

    def require_log_in 
      if !view_context.is_user_signed_in
        redirect_to(:controller=>'business', :action => 'sign_in')
      end
    end

    def require_parameters
      params.delete(:action)
      params.delete(:controller)
      redirect_to(:controller=>'business', :action => 'sign_in') if params.blank? #maybe it shouldnt be sign_in
    end

    def require_offer_ownership
      if !(Business.find(session[:id]).offers.include? params[:offer_id])
        redirect_to(:controller=>'business', :action => 'sign_in')
      end
    end

end
