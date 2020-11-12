class Relationship < ApplicationRecord
  # :class_name - 関連するモデルクラス名を指定。関連名と参照先のクラス名を分けたい場合に使う
  belongs_to :following, class_name: "User"
  belongs_to :follower,  class_name: "User"
end
