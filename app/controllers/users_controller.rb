class UsersController < ApplicationController
  def show
    # フォロー中ユーザー
    @followings = current_user.followings
    # フォローされているユーザー
    @followers = current_user.followers
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to rooms_path
    else
      redirect_back(fallback_location: rooms_path)
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
