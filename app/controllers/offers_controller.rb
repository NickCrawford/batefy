class OffersController < ApplicationController

  require_dependency "../../lib/search_helper.rb"
  require_dependency "../../lib/coordinate.rb"

  layout 'application'

  def index
    #(param(:latitude),param(:longitude),param(:miles_range))
    sh = SearchHelper.new
    sh.filterByLocation(1,4,1000)
    @businesses = sh.run
  end

  def show
      sh = SearchHelper.new
      @businesses = sh.run
  end

  def sign_in 

  end

  def create
  end

  def new
    render("new")
  end

  def edit
  end

  def delete
  end
end
