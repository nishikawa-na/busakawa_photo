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
  resources :users
  resources :posts, shallow: true do
    resources :comments, only: %i[create destroy]
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
