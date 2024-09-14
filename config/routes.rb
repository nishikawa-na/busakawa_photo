Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "static_pages#index"
  get "inquiry", to: "fotters#inquiry"
  get "terms", to: "fotters#terms"
  get "policy", to: "fotters#policy"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'user/:id/posts', to: 'users#post', as: :user_posts
  get 'user/:id/like_posts', to: 'users#like_post' , as: :user_like_posts
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  resources :line_bots, only: %i[new create]
  get "line_official" => "line_bots#official"
  post "line_bot/webhook" => "line_bots#webhook"
  resources :users do
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end
  resources :posts, shallow: true do
    resources :comments, only: %i[create destroy]
    resources :like_posts, only: %i[create destroy]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # Defines the root path route ("/")
  # root "posts#index"
end
