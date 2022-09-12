class Relationship < ApplicationRecord
  # class_name: "User"でUserモデルを参照
  #belongs_to :userとするとどっちがどっちのuserかわからなくなるため、followerとfollowedで分けている
  #class_name: "User"でuserテーブルからデータをとってきてもらう
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
