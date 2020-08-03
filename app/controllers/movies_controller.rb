class MoviesController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new
		@movie.user_id = current_user.id
		@movie.save
		if @movie.update(movie_params)
			redirect_to movie_path(@movie.id)
		else
			render new_movie_path
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@post_comment = PostComment.new
    end

    def index
    	# @movies = Movie.all
    	@search = Movie.ransack(params[:q])
    	@movies = @search.result
    end

    def users_movie_index
    	@user = User.find(params[:user_id])
    	@movies = Movie.where(user_id: @user.id)
    end

    def edit
    	@movie = Movie.find(params[:id])
    end

    def update
    	@movie = Movie.find(params[:id])
    	if @movie.update(movie_params)
    		redirect_to movie_path(current_movie)
    	else
    		render edit_movie_path(current_movie)
    	end
    end

	private
	def movie_params
		params.require(:movie).permit(:user_id, :title, :movie_url_id, :introduction, :introducer_comment)
	end

	def correct_user
		@user = User.find(params[:id])
		if current_user != @user
			redirect_to movie_path(current_movie)
		end
	end
end
