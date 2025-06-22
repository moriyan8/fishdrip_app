Rails.application.routes.draw do
  get "home/index"
  get "header_partial", to: "layouts#header_partial"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # ログイン・ログアウトルート
  get "/login", to: "sessions#new", as: :login
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'home#index'
  resources :users, only: [:new, :create, :show, :edit, :update] do
    collection do
      get 'activate', to: 'users#activate'
      get :resend_activation
    end
  end

  resources :posts, only: [:new, :create, :show, :destroy] do
    collection do
      get :map
    end
  end

  namespace :api do
    namespace :v1 do
      resources :nfts, only: [:create]
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
