module ApplicationHelper

	def is_business_signed_in 
		return !session[:business_id].nil?
	end

	def is_user_signed_in
		return !session[:user_id].nil?
	end

	def error_messages_for(object)
		render(:partial => 'application/error_messages', 
			:locals => {:object => object} )
	end

	def cp(path)
  		"current" if current_page?(path)
	end

end