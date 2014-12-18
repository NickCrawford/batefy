class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"
  require_dependency "../../lib/coordinate.rb"

  layout 'application'

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    #sh.filterByLocation(1,4,1000)
    @businesses = []
  end

  def show
      sh = SearchHelper.new
      @businesses = sh.run
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end
end
