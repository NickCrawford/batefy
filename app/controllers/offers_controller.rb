class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"

  layout 'application'

  before_filter :clear_flash, :only=> [:create,:delete]
  before_filter :require_log_in, :only => [:manage,:create,:delete]
  before_filter :require_parameters, :only => [:delete, :create]
  before_filter :require_offer_ownership, :only => [:delete]

  def index
    @latitude = request.location.latitude.to_s
    @longitude = request.location.longitude.to_s
    search = SearchHelper.new([])
    search.filter_by_location(@latitude+', '+@longitude)
    @offers = search.get_offers
  end

  def show
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @tag_id = params[:tag_id]
    @subtag_id = params[:subtag_id]
    search = SearchHelper.new([])
    search.filter_by_location(@latitude+','+@longitude)
    search.filter_by_tag(@tag_id)
    search.filter_by_subtag(@subtag_id)
    @offers = search.get_offers
    render partial: "results", locals: {offers: @offers, tag_id: @tag_id, subtag_id: @subtag_id, latitude: @latitude, longitude: @longitude}
  end

  def manage
    @business = Business.find(session[:business_id])
  end

  def create
    @offer = Offer.new(offer_params)
    if set_time_attributes_from_params
      @business = Business.find(session[:business_id])
      @business.offers << @offer
      @offer_date = OfferDate.new(offer_date_params)
      @offer.offer_dates << @offer_date
      flash[:notice]="Offer created successfully"
    else
      flash[:error]="Your offer ends before it starts!"
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

    def require_log_in 
      if !view_context.is_business_signed_in
        redirect_to(:controller=>'business', :action => 'sign_in')
      end
    end

    def require_parameters
      params.delete(:action)
      params.delete(:controller)
      redirect_to(:controller=>'business', :action => 'sign_in') if params.blank?
    end

    def require_offer_ownership
      business = Business.find(session[:business_id])
      business.offers.each do |offer|
        if offer.id == params[:offer][:offer_id].to_i
          return
        end
      end
      redirect_to(:controller=>'business', :action => 'sign_in')
    end

    def set_time_attributes_from_params
      year, month, day = params[:offer][:year].to_i, params[:offer][:month].to_i, params[:offer][:day].to_i
      start_hour, start_minute = params[:offer]['time_start(4i)'].to_i, params[:offer]['time_start(5i)'].to_i
      end_hour, end_minute = params[:offer]['time_end(4i)'].to_i, params[:offer]['time_end(5i)'].to_i
      visible_hour = start_hour - params[:offer][:visible_from].to_i
      if visible_hour < 0 
        params[:offer][:visible_from] = (Time.new(year,month,day,24+visible_hour,start_minute)-1.day).to_i
      else
        params[:offer][:visible_from] = Time.new(year,month,day,visible_hour,start_minute).to_i
      end
      params[:offer][:start_time] = Time.new(year,month,day,start_hour,start_minute).to_i
      params[:offer][:end_time] = Time.new(year,month,day,end_hour,end_minute).to_i
      return params[:offer][:end_time] > params[:offer][:start_time]
    end

    def clear_flash
      flash.clear
    end

end
