Rails.application.routes.draw do
    
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  
  resources :subjects, only: [:show, :new, :create, :edit, :update] do
      resources :comments, only: [:create, :new, :edit, :update, :destroy]
  end      
end
