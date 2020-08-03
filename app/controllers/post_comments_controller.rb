class PostCommentsController < ApplicationController
	def create
		movie = Movie.find(params[:movie_id])
		comment = current_user.post_comments.new(post_comment_params)
		comment.movie_id = movie.id
		comment.save
		redirect_to movie_path(movie)
	end

	def destroy
		PostComment.find_by(id: params[:id], movie_id: params[:movie_id]).destroy
		redirect_to movie_path(params[:movie_id])
	end
	private
	def post_comment_params
		params.require(:post_comment).permit(:comment)
	end
end
