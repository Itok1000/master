Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "static_pages#top"
  get "static_pages/top", to: "static_pages#top", as: "top" 
  get "/how_to_use", to: "static_pages#how_to_use" 
  get "/georgia", to: "static_pages#georgia" 
  get "/food", to: "static_pages#food" 
    get "/terms", to: "terms#terms"

  
  resources :diagnoses, only: %i[index show new create]
  get "images/ogp.png", to: "images#ogp", as: "images_ogp"
 



  
  resources :users, only: %i[new create]

  get "login", to: "user_sessions#new"

  post "login", to: "user_sessions#create"


  delete "logout", to: "user_sessions#destroy"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  resources :posts, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create destroy], shallow: true
    resource :favorites, only: [ :create, :destroy ]


     collection do
      get :favorites
      get :posts
     end
  end

  resource :profile, only: %i[show edit update]
  resources :password_resets, only: [ :new, :create, :edit, :update ]
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  namespace :admin do
    root "dashboards#index"
    resource :dashboard, only: %i[index]
    get "login" => "user_sessions#new", :as => :login
    post "login" => "user_sessions#create"
    delete "logout" => "user_sessions#destroy", :as => :logout
  end
end
