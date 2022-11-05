class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.score = Language.get_data(comment_params[:comment])
    @comment.save
    @comment = Comment.new
    @post.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

    private

  def comment_params
    params.require(:comment).permit(:comment,:user_id,:post_id)
  end
end
