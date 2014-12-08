class OffersController < ApplicationController

  require_dependency "../../lib/business_helper.rb"
  require_dependency "../../lib/offer_helper.rb"
  require_dependency "../../lib/coordinate"

  layout false

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    location = Coordinate.new 1,4
    lat_lng_range =location.getCoordinatesRange 1000
    bh = BusinessHelper.new lat_lng_range
    @businesses = bh.businesses
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
