Rails.application.routes.draw do
  get "access/login", to: "access#login", as: :access_login
  post "access/authenticate", to: "access#authenticate", as: :access_authenticate
  get "access/logout", to: "access#logout", as: :access_logout
  get "access/signup", to: "access#signup", as: :access_signup
  post "access/signup", to: "access#create"

  resources :orders
  get "task/add"
  get "task/delete"
  resources :cartitems
  resources :carts
  get "shopper/index"
  resources :products do
    resources :reviews, only: %i[ new create ]
  end
  resources :reviews, only: %i[ edit update destroy ]

  get "/", to: "shopper#index", as: "shopper" #shopper url
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
