class RepliesController < ApplicationController
	before_action :authenticate_user!
	def create
		@tweet = Tweet.find(params[:tweet_id])
		@reply = current_user.replies.new(reply_params)
		@reply.tweet_id = @tweet.id
		@reply.save
		redirect_to tweet_path(@tweet)
	end

	def destroy
		Reply.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
		redirect_to tweet_path(params[:tweet_id])
	end
	private
	def reply_params
		params.require(:reply).permit(:text, :user_id, :tweet_id)
	end
end
