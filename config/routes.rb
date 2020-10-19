Rails.application.routes.draw do
    
    get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end
