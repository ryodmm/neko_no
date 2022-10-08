class Public::PostsController < ApplicationController
  before_action :reject_freeze_user
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids])  #自分とフォローしているユーザの投稿を全件取得
                 .order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def ensure_user
    @post = Post.find(params[:id])
    if @post.user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end

  def post_params
    params.require(:post).permit(:name, :image, :introduction, :user_id)
  end

end
