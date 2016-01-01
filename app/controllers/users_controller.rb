class UsersController < ApplicationController
	include UsersHelper

	before_action :logged_in_user, only: [:edit, :update, :index, :destroy] 
	before_action :editing_permissions, only: [:edit, :update, :destroy]
	before_action :signup_allowed, only: [:new, :create]
	before_action :valid_user_type, only: [:update, :create]

	def index
		@users = User.where.not(id: current_user).paginate(page: params[:page], per_page: 29)
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Your account has been created for Ruby on Rails inventory management"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash.now[:success] = "Update on #{@user.email} successful"
			render 'show'
		else
			render 'edit'
		end
	end

	def destroy
		user = User.find(params[:id])
		if (current_user.user_type == "Owner" && current_user == user)
			flash[:danger] = "Owners can not delete themselves!"
		else
			user.destroy
			flash[:success] = "User deleted"
		end
			redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, 
																	:password_confirmation, 
																	:user_type)
		end

		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in"
				redirect_to login_path
			end
		end

		def signup_allowed
			#New signups allowed only if owner not present
			if ((User.where(user_type: "Owner").size > 0  || 
				User.where(user_type: 0).size > 0) && !logged_in?)
			  flash[:danger] = "Signups are not allowed at this time. Please contact a site admin"
				redirect_to root_path
			#Only Logged in owners and HR can create users
			elsif (logged_in? && 
				current_user.user_type != "Owner" && 
				current_user.user_type != "HR Manager")
			  flash[:danger] = "You don't have the ability to create users!"
				redirect_to root_path				
			end
		end

		#Checks permissions for creating valid user
		def valid_user_type
			unless (possible_user_types.include?(params[:user][:user_type]) || 
				params[:user][:user_type].nil?)
				flash[:danger] = "You are not allowed to create that type of user"
				redirect_to root_path
			end
		end

		def editing_permissions
			@edit_user = User.find(params[:id])
			#Allow edits to self, if logged in as HR manager or owner
			unless (current_user == @edit_user || 
								current_user.user_type == "HR Manager" || 
								current_user.user_type == "Owner")
				flash[:danger] = "You are not allowed to make edits to that user. Please contact HR or the owner to make edits"
				redirect_to(root_url)
			end
			#Do not allow HR to edit owners
			if (current_user.user_type == "HR Manager" && 
					@edit_user.user_type == "Owner")
				flash[:danger] = "Please contact an owner to make edits"
				redirect_to(root_url)
			end
		end
end