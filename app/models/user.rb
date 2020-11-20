class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries
  has_many :favorites
  # favorite_roomsという名前でユーザーのお気に入り一覧を取得できるようにする
  has_many :favorite_rooms, through: :favorites, source: :room

  # フォロー・フォロワーの情報を集める
  # has_many :relatinshipだと２通り書かなくてはならず名前被りが起こるので中間テーブル名を再定義する
  # =========== 自分がフォローしているユーザーとの関連 ==============
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # ===========================================================
  # ============ 自分がフォローされるユーザーとの関連 ===============
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # ===========================================================

  validates :name, inclusion: { in: %w("名無しさん.com") }

  # Userがfollow済みかどうか判定
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(name: '名無しさん.com', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
