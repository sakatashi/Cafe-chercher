class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:name, :status)
  end
end