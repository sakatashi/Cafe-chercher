class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.publish == true
        redirect_to posts_path, notice: "投稿しました。"
      else
        redirect_to posts_path, notice: "マイページの「下書き投稿」に保存しました。"
      end
    else
      redirect_to new_post_path(@post), alert: "入力内容をご確認ください。"
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
    if current_user == @post.user
      if @post.update(post_params)
        if @post.is_draft == true
          redirect_to post_path(@post.id), notice: "更新しました。"
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
  # タグ検索結果ページ
  def tag
    @tag = Tag.find_by(name: params[:name])
    @post = @tag.posts
  end

  private
  def post_params
  params.require(:post).permit(:user_id, :title, :content, :shop_name, :shop_place, :shop_holiday, :shop_price, :is_draft,:image)
  end
end