Rails.application.routes.draw do
  root 'static_pages#home'
  
  get 'search', to: 'users#search'
  post 'results', to: 'users#search'
  
  put 'accept', to: 'relationships#accept'
  get 'request_friendship', to: 'relationships#request_friendship'
  get 'requests', to: 'relationships#index'
  delete 'requests', to: 'relationships#destroy'
  
  devise_for :users
  resources :users, only: [:show, :edit]
  
  resources :posts, only: [:create, :destroy]
  
  get "like", to: "likes#like_object"
  get "unlike", to: "likes#unlike_object"
end
