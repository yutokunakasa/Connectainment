class Admin::TweetsController < ApplicationController
	before_action :if_not_admin
	def index
		@tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(15)
	end
	def destroy
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect_to admin_tweets_path
	end
	private
    def if_not_admin
		redirect_to root_path unless current_user.admin?
	end
end
