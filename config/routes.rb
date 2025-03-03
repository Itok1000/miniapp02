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
  get "/how_to_use", to: "static_pages#how_to_use"

  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :matches, only: %i[index]
end

# ●resources について
# resources メソッドは、Ruby on Railsのルーティングに広く使用され、特定のリソースに対して標準的なRESTfulルートを一括で生成する
# 例えば、resources :users と記述することで、ユーザーに関連する一連のルート（index, new, create, show, edit, update, destroy）が自動的に設定される
# これにより、コントローラの各アクションがURLとHTTPメソッドに紐づけられ、CRUD操作のルーティングが容易になる

# ●only指定について
# onlyオプションを使用すると、resources メソッドで生成されるルートの中から特定のアクションだけを選択して生成できる
# 例えば、resources :users, only: [:index] と指定すると、ユーザー一覧のルートのみを生成し、その他のアクションのルートは除外される

# ●http://localhost:3000/rails/info/routes の紹介と見方
# このURLは、開発中のRuby on Railsアプリケーションのルーティング情報を表示する特別なページ
# このページには、各ルートがどのコントローラとアクションにマッピングされているか、使用されるHTTPメソッド、URLパターンが一覧表示される
# 例えば、下記の画像の例では、ルートパス / が StaticPagesController の top アクションにマッピングされていることが確認できる

# get 'login', to: 'user_sessions#new' はログインフォームを表示するためのGETリクエストを処理する
# 一方、post 'login', to: 'user_sessions#create' はログインフォームから送信された情報を処理するPOSTリクエストを扱う
