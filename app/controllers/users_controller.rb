class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
		@information = AdminInformation.new
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

	def following
		@user = User.find(params[:id])
		@users = @user.followings
		render 'show_follow'
	end

	def followers
		@user = User.find(params[:id])
		@users = @user.followers
		render 'show_follower'
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:notice] = "退会しました"
		redirect_to root_path
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
