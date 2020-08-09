class MoviesController < ApplicationController
    before_action :authenticate_user!, only: [:show, :update]
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
    	@search = Movie.ransack(params[:q])
    	@movies = @search.result.page(params[:page]).per(20)
    end

    def users_movie_index
    	@user = User.find(params[:user_id])
    	@movies = Movie.where(user_id: @user.id).order(create_at: :desc).page(params[:page]).per(10)
    end

    def following_user_movies
    	@user = User.find(current_user.id)
        @movie_all = Movie.includes(:user)
        @following_users = @user.followings
        @movies = @movie_all.where(user_id: @following_users).order(create_at: :desc).page(params[:page]).per(10)
        	# @users = @user.followings
        	# @movies =[]
        	# if @users.present?
        	# 	@users.each do |user|
        	# 		following_user_movies = Movie.where(user_id: user.id)
        	# 		@movies.concat(following_user_movies)
        	# 	end
         #        current_user_movies = Movie.where(user_id: current_user.id)
         #        @movies.concat(current_user_movies)
        	# end
         #    @movies = Kaminari.paginate_array(@movies).page(params[:page]).per(4)
         # 学習のため、一応コメントアウトで残してあります
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

    def destroy
    	@movie = Movie.find(params[:id])
    	@movie.destroy
    	redirect_to user_users_movie_index_path(current_user)
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
