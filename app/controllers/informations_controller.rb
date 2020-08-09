class InformationsController < ApplicationController
	def index
		@informations = Information.all
	end

	def create
		@information = Information.new
		@information.save
		redirect_to user_path(current_user)
	end

	def update
		@information = Information.find
		if @information.update(information_params)
		redirect_to root_path
	    end
    end

	private
	def information_params
		params.require(:information).permit(:text)
	end
end
