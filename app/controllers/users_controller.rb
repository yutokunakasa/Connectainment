class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to user_path(current_user)
		else
			redirect_to request.referrer
		end
	end

	private
	def user_params
		params.require(:user).permit(:nickname, :introduction, :email, :icon_image)
	end

	def correct_user
		@user = User.find(params[:id])
		if current_user != @user
			redirect_to user_path(current_user)
		end
	end
end
