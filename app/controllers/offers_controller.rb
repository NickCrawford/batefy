class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"

  layout false

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    sh.filterByLocation(1,4,1000)
    @businesses = sh.run
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
