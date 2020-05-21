Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  root 'home#top'
  get 'about' => 'home#about'
  get 'howto' => 'home#howto'
  get 'word' => 'home#word'

  resources :users, only: [:show, :edit, :update]
  resources :components, only: [:index, :update, :create, :destroy, :edit]
  resources :expressions, except: [:new] do
    resources :reviews, only: [:create, :destroy]
  end
  resources :arguments, only: [:index, :create, :show] do
    resources :checks, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
