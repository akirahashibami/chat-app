class Room < ApplicationRecord

  has_many :messages
  has_many :entries
  has_many :users, through: :entries
  has_many :favorites

  validates :name, presence: true, on: :create

  # ユーザーがルームをお気に入りしているか判断メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
