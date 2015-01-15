class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"
  require_dependency "../../lib/coordinate.rb"

  layout 'application'

  before_filter :require_log_in, :only => [:new,:create,:edit,:update,:delete]
  before_filter :require_parameters, :only => [:edit, :update, :delete]
  before_filter :require_offer_ownership, :only => [:edit,:update,:delete]

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    sh.filterByPercentage(10)
    #sh.filterByLocation(1,/4,1000)
    @businesses = sh.run
  end

  def show
    sh = SearchHelper.new
    @businesses = sh.run
  end

  def new
    @offer = Offer.new
  end

  def create
    
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

    def require_log_in 
      if !view_context.is_user_signed_in
        redirect_to(:action => "sign_in")
      end
    end

    def require_parameters
      params.delete(:action)
      params.delete(:controller)
      redirect_to(:action => "sign_in") if params.blank? #maybe it shouldnt be sign_in
    end

    def require_offer_ownership
      if !(Business.find(session[:id]).offers.include? params[:offer_id])
        redirect_to(:action => "sign_in")
      end
    end

end
