Rails.application.routes.draw do
  devise_for :users
  # deviseを使用する際にURLとしてusersを含むことを示しています。
  resources :users,only: [:show,:index,:edit,:update]
  resources :books

  root 'homes#top'
  get 'home/about' => 'homes#about'

end