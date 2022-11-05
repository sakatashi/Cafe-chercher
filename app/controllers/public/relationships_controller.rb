class Public::RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer, notice: "フォローしました。"
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer, notice: "フォロー解除しました。"
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(3)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(3)
  end
end
