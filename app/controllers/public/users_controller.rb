class Public::UsersController < ApplicationController

  def show
    @users = User.all
    @user = User.find(params[:id])
    @posts = @user.posts.all
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
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  #def destroy_confirm       #ゲストが退会しようとするとログアウトしトップページへいく
    #@user = current_user
  #end

  #def destroy_user
    #@user = current_user
    #if @user.email == 'guestda@example.com'
      #reset_session
      #redirect_to :root
    #else
      #@user.update(is_valid: false)
      #reset_session
      #redirect_to :root
    #end
  #end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
