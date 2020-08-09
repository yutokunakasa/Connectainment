class Admin::UsersController < ApplicationController
	before_action :if_not_admin

	def index
		@users = User.with_deleted.where.not(id: current_user.id)
	end

	def show
		@user = User.with_deleted.find(params[:id])
	end
    def destroy
    	@user = User.find(params[:id])
	    @user.destroy
	    flash[:notice] = "退会処理を実行しました"
	    redirect_to admin_users_path
    end

	private
	def if_not_admin
		redirect_to root_path unless current_user.admin?
	end
end
