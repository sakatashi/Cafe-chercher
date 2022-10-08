class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice:'投稿しました'
    else
      render 'new', '入力内容をご確認ください。'
    end
  end

  def index
    @posts = Post.published
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def draft_index
    @posts = current_user.posts.draft
  end

  def tag
    @tag = Tag.find_by(name: params[:name])
    @post = @tag.posts
  end

  private
  def post_params
  params.require(:post).permit(:user_id, :title, :content, :shop_name, :shop_place, :shop_holiday, :shop_price, :is_draft,:image)
  end
end