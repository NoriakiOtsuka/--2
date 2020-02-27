class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy  #belong_to だとbookが親となりerrorが生じる
  attachment :profile_image, destroy: false
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    self.favorites.where(user_id: user.id).exists?
  end
  has_many :book_comments, dependent: :destroy
  
  #relationshipのアソシエーション
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end
  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
