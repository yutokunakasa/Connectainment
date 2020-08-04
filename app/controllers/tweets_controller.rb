class TweetsController < ApplicationController
	def index
		@user = current_user
		@users = @user.followings
		@tweets = []
		if @users.present?
    		@users.each do |user|
    			following_user_tweets = Tweet.where(user_id: user.id)

    			@tweets.concat(following_user_tweets)
    		end
    		current_user_tweets = Tweet.where(user_id: current_user.id)
    		@tweets.concat(current_user_tweets)
    	end

	end

	def user_tweets
		@user = User.find(params[:user_id])
		@tweets = Tweet.where(user_id: @user.id)
	end

	def show
		@tweet = Tweet.find(params[:id])
		@reply = Reply.new
	end

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new
		@tweet.user_id = current_user.id
		@tweet.save
		if @tweet.update(tweet_params)
			redirect_to tweets_path
		else
			redirect_to new_tweet_path
		end
	end

	def destroy
		@tweet = Tweet.find(params[:id])
    	@tweet.destroy
    	redirect_to user_user_tweets_path(current_user)
	end

	private
	def tweet_params
		params.require(:tweet).permit(:text, :user_id)
	end

end
