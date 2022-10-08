class Admin::RelationshipsController < ApplicationController
  before_action :admin_scan
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