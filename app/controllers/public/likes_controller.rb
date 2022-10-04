class Public::LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    like =current_user.likes.new(post_id: @post.id)
    like.save
    # app/view/likes/create.js.erbを参照
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    # app/view/likes/destroy.js.erbを参照
  end
end
