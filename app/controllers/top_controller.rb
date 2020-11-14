class TopController < ApplicationController

  layout 'top.html.slim'

  def top
    # code
  end

  def new_guest
    # userにユーザーがいる場合サインイン、いない場合create
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      # passはランダム作成
      user.password = SecureRandom.urlsafe_base64
      user.name = "名無しさん.com"
    end
    sign_in user
    redirect_to rooms_path, notice: 'ゲストユーザーとしてログインしました'
  end
end
