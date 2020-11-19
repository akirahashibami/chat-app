module ApplicationHelper

  # ゲストユーザーか判断メソッド
  def guest_user?(user)
    user.name != "名無しさん.com"
  end
  
end
