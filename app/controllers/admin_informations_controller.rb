class AdminInformationsController < ApplicationController
	before_action :if_not_admin
	def new
		@information = AdminInformation.new
	end

	def index
		@informations = AdminInformation.all.order(created_at: :desc).page(params[:page]).per(20)
	end

	def create
		@information = AdminInformation.new
		@information.save(admin_information_params)
		if @information.update(admin_information_params)
			redirect_to root_path
		end
	end

	def update
        @information = AdminInformation.find(params[:id])
        @information.update(admin_information_params)
        redirect_to root_path
	end

	def destroy
		@information = AdminInformation.find(params[:id])
		@information.destroy
		redirect_to admin_informations_path
	end

	private
	def admin_information_params
		params.require(:admin_information).permit(:text)
	end
	def if_not_admin
		redirect_to root_path unless current_user.admin?
	end
end
