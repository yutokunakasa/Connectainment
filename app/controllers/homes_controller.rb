class HomesController < ApplicationController
	def top
		@movies = Movie.order(created_at: :desc).page(params[:page]).per(3)
		@informations = AdminInformation.all.order(created_at: :desc).page(params[:page]).per(6)
	end

	def about
	end
end
