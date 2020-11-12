class RoomsController < ApplicationController
  def index
    @messages = Message.where(room_id: nil)
    # 自分以外のユーザー一覧
    @users = User.where.not(id: current_user.id)
    # フォロー中ユーザー
    @followings = current_user.followings
    # フォローされているユーザー
    @followers = current_user.followers
  end

  def show
    @user = User.find_by(id: params[:id])
    current_room = Entry.where(user_id: current_user.id)
    another_room = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      current_room.each do |cr|
        another_room.each do |ar|
          # ルームが存在する時 かつ ルームのユーザーIDが2人（グループとの差別化）
          if cr.room_id == ar.room_id && Room.find_by(id: cr.room_id).users.ids.size == 2
            @is_room = true
            @room = Room.find_by(id: cr.room_id)
            @messages = @room.messages
          end
        end
      end
      # なければ新規作成
      unless @is_room
        @room = Room.create
        Entry.create(user_id: current_user.id, room_id: @room.id)
        Entry.create(user_id: params[:id].to_i, room_id: @room.id)
      end
    end
    @messages = @room.messages
  end

end
