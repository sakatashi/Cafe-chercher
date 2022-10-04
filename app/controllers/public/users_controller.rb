class Public::UsersController < ApplicationController
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
  end

   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :status, :image)
  end
end
