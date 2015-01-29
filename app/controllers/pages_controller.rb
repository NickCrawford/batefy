class PagesController < ActionController::Base
  
  layout "application"

  def show
  	render params[:page]
  end
end