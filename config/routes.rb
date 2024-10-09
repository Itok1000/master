Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"
  # ルート側にdiagnoses(診断機能)を追加
  # 現在のroutes.rbでは、診断機能を提供するresources :diagnosesに対してindexとshowアクションしかルートが設定されていないが
  # トップページから診断フォーム（newアクション）に進む必要がある
  resources :diagnoses, only: %i[index show new create]
end
