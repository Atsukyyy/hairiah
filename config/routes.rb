Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home' # => root_path
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/privacy_policy', to: 'static_pages#privacy_policy'
  get '/terms', to: 'static_pages#terms'
  get '/staff_usage', to: 'static_pages#staff_usage'
  get '/usage', to: 'static_pages#usage'

  get '/signup_page', to: 'static_pages#signup_page'
  get '/staff_signup_page', to: 'static_pages#staff_signup_page'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/staff_signup', to: 'users#staff_new'
  post '/staff_signup', to: 'users#staff_create'
  get '/staffs', to: 'users#staff_index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'auth/facebook/callback', to: 'omniauth#facebook'
  post 'auth/facebook/callback', to: 'omniauth#facebook'
  get 'auth/line/callback', to: 'omniauth#line'
  post 'auth/line/callback', to: 'omniauth#line'
  get 'auth/google_oauth2/callback', to: 'omniauth#google'
  post 'auth/google_oauth2/callback', to: 'omniauth#google'
  get 'auth/failure', to: 'omniauth#failure'
  post 'auth/failure', to: 'omniauth#failure'

  resources :users do
    member do
      # /users/:id/ ...
      get :following, :followers
      get '/change_password', to: 'users#password'
      # GET /users/1/following => following action
      # GET /users/1/followers => followers action
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts
  resources :microposts do
    resources :applies
  end
  resources :relationships,       only: [:create, :destroy]

  mount ActionCable.server => '/cable'


  # 連動プルダウン
  get 'prefectures/areas'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
