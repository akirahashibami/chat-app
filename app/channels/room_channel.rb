class RoomChannel < ApplicationCable::Channel
  def subscribed
    # 接続
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # 切断
  end

  # coffeeから送られて来たmessage(event.target.value)を受け取る
  # inputタグの文字がメッセージカラムに保存される
  def speak(message)
    Message.create(message: message['message'], user_id: message['user'].to_i, room_id: params['room'])
  end
end
