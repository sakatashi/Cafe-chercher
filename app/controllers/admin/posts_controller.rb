class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
     @comment = Comment.new
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_user_posts_path, notice: '投稿を削除しました。'
  end

   private
  def post_params
  params.require(:post).permit(:user_id, :title, :content, :shop_name, :shop_place, :shop_holiday, :shop_price, :is_draft,:image,:lat,:lng,shop_tag_ids:[])
  end
end

