class OffersController < ApplicationController

  require_dependency "../../lib/business_helper.rb"
  require_dependency "../../lib/offer_helper.rb"
  require_dependency "../../lib/coordinate"

  layout 'application'

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    location = Coordinate.new 1,4
    lat_lng_range =location.getCoordinatesRange 1000
    oh = OfferHelper.new(1,4,1000)
    #@offers = Offer.order(params[:sort])
     @offers = oh.offers
  end

  def show
  end

  def new
  end

  def edit
  end

  def delete
  end
end
