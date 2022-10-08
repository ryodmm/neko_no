class Admin::FreezesController < ApplicationController
  before_action :admin_scan
  def create
    User.find(params[:user_id]).create_freeze
    redirect_to admin_user_freezes_path
  end

  def destroy
    User::Freeze.where(user_id: params[:user_id]).destroy_all
    redirect_to admin_user_freezes_path
  end

  def index
    @users = User.joins(:freeze).where.not(freeze: nil).order(:id)
  end
end
