Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home' # => root_path
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/staff_signup', to: 'users#staff_new'
  post '/staff_signup', to: 'users#staff_create'
  get '/staffs', to: 'users#staff_index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      # /users/:id/ ...
      get :following, :followers
      # GET /users/1/following => following action
      # GET /users/1/followers => followers action
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  mount ActionCable.server => '/cable'

  # 連動プルダウン
  get 'prefectures/areas'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
