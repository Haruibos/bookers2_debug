Rails.application.routes.draw do
  devise_for :users
  # deviseを使用する際にURLとしてusersを含むことを示しています。

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
   resource :favorites, only: [:create, :destroy]
   # アクションのindexに対応するルートがない
   # 単数にすると、idパラメータを要求していない
   # いいねの詳細ページは作成しません。favoritesのshowページが不要で、idの受け渡しも必要ないので、resourceとなっています。
   resources :book_comments, only: [:create, :destroy]
  end
  # ユーザーに対してコメントされるため｛いいねとコメント｝はユーザーに結び付く
  # この親子関係を、[ネストする]と言う。

  resources :users, only: [:index, :show, :edit, :update]

end