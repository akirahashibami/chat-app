class RoomsController < ApplicationController

  def index
    @room = Room.new
    @rooms = Room.where.not(name: nil).order(created_at: :desc).limit(50)
    @mutual_follow = current_user.followings & current_user.followers
    @users = User.where.not(id: current_user.id)
  end

  def create
    @room = Room.create(room_params)
    Entry.create(user_id: current_user.id, room_id: @room.id)
    redirect_to group_path(@room.id)
  end

  def group
    @room = Room.find(params[:id])
    @messages = @room.messages
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
            @messages = @room.messages.last(10)
            @messages_all = @room.messages
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
  end

  private

  def room_params
     params.require(:room).permit(:name, :user_id)
  end

end
