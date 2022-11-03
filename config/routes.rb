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


  # ゲストユーザ　ログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者
  namespace :admin do
    resources :users, except: [:new, :create, :destroy]do
      resources :posts, only: [:show, :index, :destroy]
      resources :comments, only: [:index, :destroy]
    end
    resources :tags, except:[:show, :index]
    resources :shop_tags, except:[:index]
  end

	# ユーザ
  scope module: :public do
    get "about" => "homes#about"
    resources :notifications, only: [:index, :destroy]
    resources :users, only: [:show,:index, :edit, :update] do
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      member do
      get :likes
    end
  end
    # 投稿機能
    resources :posts do
      #マップ編集
      get "map/edit" => "posts#map_edit"
      #コメント・お気に入り機能
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    # ユーザの退会確認ページ
    get "user/unsubscribe" => "users#unsubscribe"
    #ユーザ退会処理
    patch "user/withdraw" => "users#withdraw"
    #下書き機能
    get "draft_index" => "posts#draft_index"
    #キーワード検索
    get 'search' => 'searches#search'
    # タグ検索結果ページ
    get "post/tag/:name" => "posts#tag"
    #こだわりタグ検索結果ページ
    get "post/shop_tag/:name" => "posts#shop_tag"
     # チャット機能
       # チャット機能
    get "chat/:id" => "chats#show", as: "chat"
    resources :chats, only: [:create]
  end


  root to: 'public/homes#top'
end
