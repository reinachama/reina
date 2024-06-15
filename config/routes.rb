Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :maps
  resources :tweets do
    
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  root 'tweets#index'


  
end
