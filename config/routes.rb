Rails.application.routes.draw do
#ユーザ用 新規登録・ログイン
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

#管理者用　ログイン
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end

# 管理者
namespace :admin do
resources :users, except: [:new, :create,] do
resources :posts, only: [:show, :index, :destroy]
resources :comments, only: [:index, :destroy]
end
resources :post_tags, except:[:show, :index]
end
	# ユーザ
scope module: :public do
root to: "homes#top"
get "about" => "homes#about"
resources :users, only: [:show, :edit, :update] do
# ユーザーの投稿一覧
get "posts" => "users#posts"
# 非公開記事一覧ページ
get "draft_index" => "posts#draft_index"
end
# ユーザの退会確認ページ
get "user/unsubscribe" => "users#unsubscribe"
get "user/withdraw" => "users#withdraw"

# キーワード検索結果ページ
get "search" => "searches#search"

# 投稿機能
resources :posts do
#コメント・お気に入り機能
resources :comments, only: [:new, :create, :destroy]
resource :likes, only: [:create, :destroy]
end
end