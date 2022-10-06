class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @post = Post.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(status: true)
    reset_session
    redirect_to root_path
  end

   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :status, :image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
