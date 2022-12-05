class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published.page(params[:page]).per(2)
  end

  def index
     @users = User.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path,
      notice: "ユーザ情報を更新しました。"
    else
      redirect_to edit_user_path(@user),
      alert: "編集内容をご確認ください。"
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(status: true)
    reset_session
    redirect_to root_path
  end

  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  def follows
  user = User.find(params[:id])
  @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
  user = User.find(params[:id])
  @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def chat_rooms
    # 現在チャットルームのあるユーザー
    user_rooms = current_user.rooms
    follow_users = current_user.followers
    @chat_room_users = User.joins(:rooms)
    .where(rooms: { id: user_rooms })
    .where(id: follow_users)
    .where.not(id: current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :status, :image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
