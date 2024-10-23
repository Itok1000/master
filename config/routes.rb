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

  get "/georgia", to: "static_pages#georgia" # ジョージアページのルートを追加(ボタンをクリックすると、app/views/static_pages/georgia.html.erbに遷移するようにルートを設定し、リンクを修正するから)


  # ルート側にdiagnoses(診断機能)を追加
  # 現在のroutes.rbでは、診断機能を提供するresources :diagnosesに対してindexとshowアクションしかルートが設定されていないが
  # トップページから診断フォーム（newアクション）に進む必要がある
  resources :diagnoses, only: %i[index show new create]
  get "images/ogp.png", to: "images#ogp", as: "images_ogp"
  # ●resources について
  # Ruby on Railsのルーティングに広く使用され、特定のリソースに対して標準的なRESTfulルートを一括で生成
  # 例えば、resources :users と記述することで、ユーザーに関連する一連のルート（index, new, create, show, edit, update, destroy）が自動的に設定される
  # これにより、コントローラの各アクションがURLとHTTPメソッドに紐づけられ、CRUD操作のルーティングが容易になる

  # ●only指定について
  # onlyオプションを使用すると、resources メソッドで生成されるルートの中から特定のアクションだけを選択して生成できる
  # 例えば、resources :users, only: %i[new create] と指定すると、ユーザーの新規作成のみを生成し、
  # その他のアクションのルートは除外される
  # ログインログアウト時のルート追加
  resources :users, only: %i[new create]
  # get 'login', to: 'user_sessions#new' はログインフォームを表示するためのGETリクエストを処理
  get "login", to: "user_sessions#new"
  # post 'login', to: 'user_sessions#create' はログインフォームから送信された情報を処理するPOSTリクエストを扱う
  post "login", to: "user_sessions#create"
  # delete 'logout', to: 'user_sessions#destroy' は、Railsのルーティング設定でログアウト機能を実装するために使用される記述
  # HTTP の DELETE メソッドを利用し、logout パスへのリクエストがあった場合に user_sessions コントローラーの destroy アクションを呼び出す。
  # このアクションでは、ユーザーのセッションを終了させるログアウト処理が行われる
  # ユーザーがログアウトボタンをクリックすると、サーバーによってセッションが破棄され、その後ユーザーはログイン画面やホームページにリダイレクトされる流れになる
  delete "logout", to: "user_sessions#destroy"
  # ルート側にposts(掲示板機能)を追加
  # resourcesメソッドのonlyオプションにnewを記載することで、GETメソッドで /posts/new というURLパターンにリクエストが飛んだ際に boardsコントローラーのnewアクションが動くように定義され
  resources :users, only: %i[new create]
  # resources :posts, only: %i[index new create] を記載することで、掲示板の一覧表示と新規作成画面へのルーティングが設定される
  # createを記載することで、POSTメソッドで /boards というURLパターンにリクエストが飛んだ際に boardsコントローラーのcreateアクションが動くように定義される
  # また、URLパターンを生成してくれる boards_path（URLヘルパー）も生成される
  resources :posts, only: %i[index new create]
  get "/food", to: "static_pages#food"
  # resourcesメソッドのonlyオプションにnewを記載することで、GETメソッドで /posts/new というURLパターンにリクエストが飛んだ際に
  # boardsコントローラーのnewアクションが動くように定義される
  # また、URLパターンを生成してくれる new_posts_path（URLヘルパー）も生成される
end
