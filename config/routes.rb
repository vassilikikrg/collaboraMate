Rails.application.routes.draw do
  resources :contacts, only: [:create, :update, :destroy]
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => 'users/omniauth_callbacks',
  :sessions => 'users/sessions',}
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  
  namespace :group do 
    resources :conversations do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [:index, :create]
  end

  namespace :private do 
    resources :conversations, only: [:create] do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [:index, :create]
  end
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'pages#index'
  mount ActionCable.server => '/cable'

  get 'messenger', to: 'messengers#index'
  get 'get_private_conversation', to: 'messengers#get_private_conversation'
  get 'get_group_conversation', to: 'messengers#get_group_conversation'
  get 'open_messenger', to: 'messengers#open_messenger'

end
