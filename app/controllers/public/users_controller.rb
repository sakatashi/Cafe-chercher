class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def update
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
end
