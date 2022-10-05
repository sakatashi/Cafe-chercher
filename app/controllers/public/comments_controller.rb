class Public::CommentsController < ApplicationController
def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find_by(post_id: @post.id)
    @comment.destroy
  end

    private

  def comment_params
    params.require(:comment).permit(:comment,:user_id,:post_id)
  end
end
