class RoomsController < ApplicationController

  def new
    @room = Room.new
    @followers = current_user.followings & current_user.followers
  end

  def index
    @room = Room.new
    # ルームの名前がなく、グループ判定がtureのものを除くルーム(つまりオープンルーム)
    @rooms = Room.where.not(name: nil, group_judg: true).order(created_at: :desc).limit(50)
    # ログインユーザーが参加しているグループを集める
    group = []
    group_room = Room.where(group_judg: true)
    group_room.each do |r|
      if r.entries.find_by(user_id: current_user.id)
        group.push(r)
      end
    end
    @group = group
    @mutual_follow = current_user.followings & current_user.followers
    @users = User.where.not(id: current_user.id)
    @favorite_rooms = current_user.favorite_rooms
  end

  def create
    if params[:room][:user_ids].nil?
      @room = Room.new(room_params)
      if @room.save
        Entry.create(user_id: current_user.id, room_id: @room.id)
        redirect_to group_path(@room.id)
      else
        redirect_back(fallback_location: rooms_path)
      end
    elsif params[:room][:user_ids].present?
      room = Room.new
      room.group_judg = true
      if room.save
        room.update(room_user_params)
        @room = room
      else
        redirect_back(fallback_location: rooms_path)
      end
    else
      redirect_to rooms_path
    end
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
        @messages_all = @room.messages
      end
    end
  end

  def edit
    @room = Room.find(params[:id])
    @followers = current_user.followings & current_user.followers
  end

  def update
    room = Room.find(params[:id])
    room.update(room_user_params)
    redirect_to(group_path(room.id))
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def room_user_params
    # :user_idsに常に自分のidが入るようにする
    params[:room][:user_ids].push(current_user.id)
    params.require(:room).permit(:name, user_ids: [])
  end

end
