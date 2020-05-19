Rails.application.routes.draw do

  devise_for :users
  root 'home#top' 
  get 'about' => 'home#about'
  get 'howto' => 'home#howto'

  resources :users, only: [:show, :edit, :update]
  resources :components, only: [:index, :update, :create, :destroy]
  resources :expressions do
    resources :reviews, only: [:create, :destroy]
  end
  resources :arguments, only: [:index, :create] do
    resources :checks, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

end
