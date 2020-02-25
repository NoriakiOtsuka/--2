class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		#p self.id
		#p user.id
		#p self.favorites
		self.favorites.where(user_id: user.id).exists?
	end
	has_many :book_comments, dependent: :destroy

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
