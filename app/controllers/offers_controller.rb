class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"
  require_dependency "../../lib/coordinate.rb"

  layout 'application'

  before_filter :require_log_in, :only => [:manage,:create,:delete]
  before_filter :require_parameters, :only => [:delete, :create]
  #before_filter :require_offer_ownership, :only => [:delete]

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    sh.filterByPercentage(10)
    sh.filterByLocation(1,4,1000)
    @businesses = sh.run
  end

  def show 
    tag_businesses = Tag.find(params[:tag_id]).businesses
    subtag_businesses = Subtag.find(params[:subtag_id]).businesses
    search_businesses = Business.near(params[:search])
    businesses = [tag_businesses, subtag_businesses, search_businesses].reduce {|memo,temp| memo & temp if !temp.blank?}
    @offers = []
    businesses.each do |business|
       @offers << business.offers
    end
    @offers.flatten!
  end

  def manage
    @business = Business.find(session[:id])
  end

  def create
    @offer = Offer.new(offer_params)
    if set_time_attributes_from_params
      @business = Business.find(session[:id])
      @business.offers << @offer
      @offer_date = OfferDate.new(offer_date_params)
      @offer.offer_dates << @offer_date
      flash[:notice]="Offer created successfully"
    else
      flash[:notice]="Your offer ends before it starts!"
    end
    redirect_to(:action => "manage") 
  end

  def delete
    @offer = Offer.find(params[:offer][:offer_id])
    @offer.destroy
    flash[:notice] = "Offer successfully deleted"
    redirect_to(:action => "manage")
  end

  private

    def offer_params
      params.require(:offer).permit(:percentage)
    end

    def offer_date_params 
      params.require(:offer).permit(:start_time,:end_time,:visible_from)
    end

    def set_time_attributes_from_params
      year, month, day = params[:offer][:year].to_i, params[:offer][:month].to_i, params[:offer][:day].to_i
      start_hour, start_minute = params[:offer]['time_start(4i)'].to_i, params[:offer]['time_start(5i)'].to_i
      end_hour, end_minute = params[:offer]['time_end(4i)'].to_i, params[:offer]['time_end(5i)'].to_i
      visible_hour = start_hour - params[:offer][:visible_from].to_i
      params[:offer][:start_time] = Time.new(year,month,day,start_hour,start_minute).to_i
      params[:offer][:end_time] = Time.new(year,month,day,end_hour,end_minute).to_i
      params[:offer][:visible_from] = Time.new(year,month,day,visible_hour,start_minute).to_i
      return params[:offer][:end_time] >= params[:offer][:start_time]
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
      business = Business.find(session[:id])
      business.offers.each do |offer|
        if offer.id == params[:offer][:offer_id]
          return
        end
      end
      redirect_to(:controller=>'business', :action => 'sign_in')
    end

end
