class Tweet < ApplicationRecord
	belongs_to :user
	has_many :replies

	validates :text, length:{in: 1..200 }
end
