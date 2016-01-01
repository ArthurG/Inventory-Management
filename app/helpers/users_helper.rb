module UsersHelper
	
	def possible_user_types
		#Logged in user can't change own user type
		if logged_in? && current_user.id.to_s === params[:id]
			[current_user.user_type]		
		#Logged in HR can't set someone as owner	
		#If an owner exists, new user can't be signup to be owner
		elsif (logged_in? && current_user.user_type == "HR Manager") ||
					(!logged_in? && User.where(user_type: "Owner").size > 0)
			types = User.user_types.keys
			types.delete("Owner")
			types			
		else
			User.user_types.keys
		end	

	end

	def editable

	end


end
