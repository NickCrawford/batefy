module ApplicationHelper

	def is_user_signed_in 
		return !session[:id].nil?
	end

	def error_messages_for(object)
		render(:partial => 'application/error_messages', 
			:locals => {:object => object} )
	end


end