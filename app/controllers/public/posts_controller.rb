class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
 
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
  
  def index
    @posts = Post.all
    @post = Post.new
    @posts = Post.where(is_draft: :published).order(params[:sort]).page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
  
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def draft_index
  end
  
  def tag
  end
 
  private
  def post_params
  params.require(:post).permit(:user_id, :title, :content, :shop_name, :shop_place, :shop_holiday, :shop_price, :is_draft,:image)
  end
end