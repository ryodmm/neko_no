class Admin::UsersController < ApplicationController
  before_action :admin_scan
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def freeze_users
    @users = User.freezed
  end

  def add_freeze
    @user = User.find(params[:id])
    @user.update(is_freeze: true) if @user.is_freeze == false
    redirect_to request.referer
  end

  def remove_freeze
    @user = User.find(params[:id])
    @user.update(is_freeze: false) if @user.is_freeze == true
    redirect_to request.referer
  end

end
