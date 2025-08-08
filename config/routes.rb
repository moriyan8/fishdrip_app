Rails.application.routes.draw do
  get "agreements/show"
  get "agreements/agree"
  get "pages/terms"
  get "pages/privacy"
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
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Defines the root path route ("/")
  # root "posts#index"

  # 利用規約、プライバシーポリシー
  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"

  get "/policy_agreement", to: "agreements#show"
  post "/policy_agreement", to: "agreements#agree"

  # Googleログイン
  get "/oauth/callback", to: "oauths#callback"
  get "/login/:provider", to: "oauths#oauth", as: :auth_at_provider

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "home#index"
  resources :users, only: [ :new, :create, :show, :edit, :update ] do
    collection do
      get "activate", to: "users#activate"
      get :resend_activation
    end
  end

  resources :posts, only: [ :new, :create, :show, :destroy ] do
    resource :favorites, only: [ :create, :destroy ]
    collection do
      get :map
    end
  end

  namespace :api do
    namespace :v1 do
      resources :nfts, only: [ :create ]
    end
  end

  resources :sessions, only: [ :new, :create, :destroy ]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
