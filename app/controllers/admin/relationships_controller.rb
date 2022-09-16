class Admin::RelationshipsController < ApplicationController
  def followings
    user = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @users = user.followers
  end
end