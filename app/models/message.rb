class Message < ApplicationRecord
  # メッセージの保存ができた時、jobにデータを渡す
  after_create_commit { MessageBroadcastJob.perform_later self}

  belongs_to :user
  belongs_to :room, optional: true

  validates :message, presence: { message: 'を入力してください'}, length: { maximum: 128 }
end
