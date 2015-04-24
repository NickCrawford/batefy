class BusinessNotifier < ActionMailer::Base
  default from: "info@batefy.com"

  def forgot_password(business, link)
  	@business = business
  	@link = link
  	mail(to: @business.email, 
  		subject:"Instructions on resetting your password")
  end

end
