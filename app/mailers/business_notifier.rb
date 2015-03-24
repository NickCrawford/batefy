class BusinessNotifier < ActionMailer::Base
  default from: "info@batefy.com"

  def forgot_password(business, link)
  	@buisess = business
  	@link = link
  	mail(to: @business.mail, 
  		subject:"Instructions on resetting your password")
  end

end
