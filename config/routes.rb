Rails.application.routes.draw do
  namespace :admin do
    get 'comments/index'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'post_tags/new'
    get 'post_tags/edit'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/unsubscribe'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
#ユーザ用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

#管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end