class Book < ApplicationRecord
	belongs_to :user

	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	# favorited_by?メソッド
	# このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    # 存在していればtrue、存在していなければfalseを返すようにしています。
end
# PostImageモデルと同じ