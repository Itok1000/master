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
  get "/food", to: "static_pages#food" # ジョージア料理とは何かのルートを追加(ボタンをクリックすると、app/views/static_pages/food.html.erbに遷移するようにルートを設定し、リンクを修正するから)
  get '/terms', to: 'terms#terms' # 利用規約のルートを追加

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
  # resourcesメソッドのonlyオプションにnewを記載することで、GETメソッドで /posts/new というURLパターンにリクエストが飛んだ際に postsコントローラーのnewアクションが動くように定義される
  # resources :users, only: %i[new create]
  # resources :posts, only: %i[index new create show] を記載することで、掲示板の一覧表示と新規作成画面,掲示板詳細閲覧のルーティングが設定される
  # createを記載することで、POSTメソッドで /posts というURLパターンにリクエストが飛んだ際に postsコントローラーのcreateアクションが動くように定義される
  # また、URLパターンを生成してくれる posts_path（URLヘルパー）も生成される

  # 投稿のリソース(一覧、新規作成、詳細、編集、削除、更新)
  # コメントのリソース(作成、編集、削除)
  # いいねのリソース(作成、削除)
  resources :posts, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create destroy], shallow: true
    resource :favorites, only: [ :create, :destroy ]


     collection do
      get :favorites
      get :posts
     end
    #### **いいねのリソースだけ複数形でない理由**
    # いいね機能の場合、1人のユーザーは1つの投稿に対して1回しかいいねできないという制約がある
    # そのため、いいねの削除を行う際には、ユーザーIDと投稿IDがわかれば、どのいいねを削除するかを特定できる
    # したがって、いいねのIDをURLに含める必要はない
    ### **resourcesとresourceの違い**
    # URLに:idを含めるかどうか
    # resourcesを使用すると:idが含まれ、特定の要素を操作するためのIDが必要
    # 一方、resourceを使用すると:idが含まれず、他のリソースとの関連付けによって特定できる

    #### **ネストしたルーティングについて**
    # あるリソースが別のリソースに属する形でルーティングを定義すること
    # ネスト
    # 入れ子構造のことを意味し、プログラミングでは、ある要素が他の要素の内部に含まれている状態を指す
    # 例⇒掲示板（Post）に属するコメント（Comment）を扱う場合、commentsリソースをpostsリソースの中にネスト
    # こうすることで、URLが直感的になり、関連するリソースの関係が明確になる

    ### **shallow オプションについて**
    # shallowオプションは、ネストしたリソースの一部のアクションに対して、親リソースのIDを含まないURLを生成するために使用する
    # 例えば、コメントの編集や削除アクションでは、特定のコメントを操作するために掲示板のIDは必要ない
    # このような場合、shallowオプションを使うことで、URLを簡潔にし、可読性を向上させることができる

    ### **collection**
    # collectionは、resorces, resorceで作成されるRESTfulなルーティングにアクションを追加する際に使用
    # RESTfulなルーティングにアクションを追加するものとしてmemberもあるが、
    # memberは個々のリソースに対するアクション、collectionはリソース全体に対するアクションに使用
    # 個々の掲示板（post）に対してプレビューを行いたいとかではなく、掲示板全体（posts）の中からブックマークされている
    # 掲示板の一覧を表示したいということで、collectionを使って get :bookmarks を記述している
  end

  resource :profile, only: %i[show edit update]
  # resourcesメソッドのonlyオプションにnewを記載することで、GETメソッドで /posts/new というURLパターンにリクエストが飛んだ際に
  # postsコントローラーのnewアクションが動くように定義される
  # また、URLパターンを生成してくれる new_posts_path（URLヘルパー）も生成される
end
