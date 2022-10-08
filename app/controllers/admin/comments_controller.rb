class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_user_comments_path, notice: 'コメントを削除しました。'
  end
end
