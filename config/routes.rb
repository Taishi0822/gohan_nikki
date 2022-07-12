Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    resources :users, only:[:show, :edit, :update] do
     member do
       get :favorites
       get :checks
     end
    end
    resources :menus, only:[:new, :create, :show, :index, :edit, :update, :destroy] do
      resource :favorites, only:[:create, :destroy]
      resource :checks, only:[:create, :destroy]
    end
  #退会確認ページ
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  #退会保存する
    patch '/users/:id/withrawal' => 'users#withrawal', as: 'withrawal'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only:[:index, :show, :edit, :update]
    resources :menus, only:[:index, :show, :edit, :update, :destroy]
    resources :genres, only:[:index, :create, :edit, :update, :destroy]

  end

end
