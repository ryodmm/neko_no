class Public::UsersController < ApplicationController
  before_action :reject_freeze_user

  def show
    @users = User.all
    @user = User.find(params[:id])
    @posts = @user.posts.all
                        .order(created_at: :desc)
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)  #where: 与えられた条件にマッチするレコードを全て取得
    @favorite_posts = Post.find(favorites)                        #pluck: 1つのモデルで使用されているテーブルからカラム (1つでも複数でも可) を取得
  end                                                             #Product.pluck(:name)という記述があった場合、
                                                                  #productモデルのnameカラムの一覧を持ってくる。

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = current_user
    if @user.email == 'guest@example.com'     #ゲストユーザが退会しようとした場合、ログアウトしルートパスへ遷移
      reset_session
      redirect_to :root
    else
      @user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end
  end

  def release
    @user = current_user
    @user.released! unless @user.released?
    redirect_to  request.referer, notice: 'このアカウントを公開しました'
  end

  def nonrelease
    @user = current_user
    @user.nonreleased! unless @user.nonreleased?
    redirect_to request.referer, notice: 'このアカウントを非公開にしました'
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
