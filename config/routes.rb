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

  get 'users/trust' => 'users#trust_user', as: :trust_user
  get 'users/:id/quit' => 'users#quit', as: :quit
  put 'users/:id/invalid' => 'users#invalid', as: :invalid
  get 'checks' => 'checks#index', as: :checks
  get 'users' => 'users#index'

  resources :users, only: [:show, :edit, :update]
  resources :components, only: [:index, :update, :create, :destroy, :edit]
  resources :expressions, except: [:new]
  resources :reviews, only: [:create, :update]
  resources :arguments, only: [:index, :create, :show] do
    resource :check, only: [:create, :destroy]
  end
  resources :relationships, only: [:index, :create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :events do
    resources :event_comments, only: [:create, :destroy]
    resource :participation, only: [:create, :destroy]
  end
end
