class Movie < ApplicationRecord
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true
	validates :movie_url_id, presence: true
	validates :introduction, presence: true
	validates :introducer_comment, length:{in: 1..200 }

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end

# class MoviesController < ApplicationController
# 	def index
# 		@movies = Movies.limit(10).sort_by { |movie| movie.sum_comments_score }
# 	end
# end
# メンターさんから教えていただいた事項につきコメントアウトで一時的に残してあります。