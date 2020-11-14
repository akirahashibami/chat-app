class UsersController < ApplicationController
  def show
    # フォロー中ユーザー
    @followings = current_user.followings
    # フォローされているユーザー
    @followers = current_user.followers
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
