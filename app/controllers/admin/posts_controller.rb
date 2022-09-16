class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def search
    @range = params[:range]
    @order = params[:order]
    @user = params[:user_id]
    if @range == 'ユーザ'
      @users = User.search(params[:word])

    elsif @range == '投稿' && @order == '人気順'
      @posts = Post.search(params[:word])
                   .includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}

    elsif @range == '投稿' && @order == '新着順'
      @posts = Post.search(params[:word])
                   .order(created_at: :desc)

    else
      @posts = Post.search(params[:word])
    end
  end
end
