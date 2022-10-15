class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.is_draft == true
        redirect_to posts_path, notice: "投稿しました。"
      else
        redirect_to posts_path, notice: "マイページの「下書き投稿」に保存しました。"
      end
    else
      redirect_to new_post_path(@post), alert: "入力内容をご確認ください。"
    end
  end

  def index
    @post = Post.new
    @posts = params[:shop_tag_ids].present? ? ShopTag.find(params[:shop_tag_ids]).posts.page(params[:page]) : Post.published.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @shop_tags = @post.tags


  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if current_user == @post.user
      if @post.update(post_params)
        if @post.is_draft == true
          redirect_to post_path(@post), notice: "更新しました。"
        else
          redirect_to post_path(@post),
          notice: "マイページの「下書き投稿」に保存しました。"
        end
      else
        redirect_to edit_post_path(@post), alert: "編集内容をご確認ください。"
      end
    else
      redirect_to posts_path, alert: "本人以外更新できません。"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました。"
    else
      redirect_to posts_path, alert: "本人以外は投稿を削除できません。"
    end
  end

#非公開ページ
  def draft_index
    @posts = current_user.posts.draft
  end

   # こだわりタグ検索結果ページ
  def shop_tag
    @shop_tag = ShopTag.find_by(name: params[:name])
    @post = @shop_tag.posts.page(params[:page])
   

  end
  # タグ検索結果ページ
  def tag
    @tag = Tag.find_by(name: params[:name])
    @post = @tag.posts.page(params[:page])
  end

  private
  def post_params
  params.require(:post).permit(:user_id, :title, :content, :shop_name, :shop_place, :shop_holiday, :shop_price, :is_draft,:image,shop_tag_ids:[])
  end
end