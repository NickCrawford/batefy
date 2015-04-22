module ApplicationHelper

	def time_zone
		cookies["time_zone"]
	end

	def is_business_signed_in 
		return !session[:business_id].nil?
	end

	def is_user_signed_in
		return !session[:user_id].nil?
	end

	def has_user_gotten_offer(offer_id)
		@user = User.find_by_id(session[:user_id])
		@offers = @user.offers
		@offers.each do |offer|
			if offer.id == offer_id
				return true
			end
		end 
		false
	end

	def error_messages_for(object)
		render(:partial => 'application/error_messages', 
			:locals => {:object => object} )
	end

	def cp(path)
  		"current" if current_page?(path)
	end

end