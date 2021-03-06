class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :icon_image
  has_many :movies
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  has_many :tweets
  has_many :replies

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :nickname, presence: true

  acts_as_paranoid

  def following?(other_user)
  	following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
  	following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
  	following_relationships.find_by(following_id: other_user.id).destroy
  end
end
