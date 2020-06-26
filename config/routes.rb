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
  get 'report' => 'inquiries#report'
  get 'contact' => 'inquiries#contact'
  post 'inquiry' => 'inquiries#create'
  post '/guest_sign_in' => 'home#guest'

  get 'users/trust' => 'users#trust_user', as: :trust_user
  get 'users/:optional_id/quit' => 'users#quit', param: :optional_id, as: :quit
  put 'users/:optional_id/invalid' => 'users#invalid', param: :optional_id, as: :invalid
  get 'checks' => 'checks#index', as: :checks
  put 'notifications/look', as: :looks

  resources :users, param: :optional_id, only: [:index, :show, :edit, :update]
  resources :components, only: [:index, :update, :create, :destroy, :edit]
  resources :expressions, except: [:new]
  resources :reviews, only: [:create, :update]
  resources :arguments, only: [:index, :create, :show] do
    resource :check, only: [:create, :destroy]
  end
  resources :relationships, only: [:index, :create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :events, except: [:new, :destroy] do
    resources :event_comments, only: [:create]
    resource :participation, only: [:create, :destroy]
  end
  resources :notifications, only: [:index]
end
