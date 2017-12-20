Rails.application.routes.draw do
  root 'static_pages#home'
  
  # Comments
  get 'comments/create'
  get 'comments/destroy'
  post "comments", to: "comments#create"
  delete "comments", to: "comments#destroy"
  
  # Search
  get 'search', to: 'users#search'
  post 'results', to: 'users#search'
  
  # Relationships
  put 'accept', to: 'relationships#accept'
  get 'request_friendship', to: 'relationships#request_friendship'
  get 'requests', to: 'relationships#index'
  delete 'requests', to: 'relationships#destroy'
  
  # Users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  resources :users, only: [:show, :index]
  
  # Posts
  resources :posts, only: [:create, :destroy]

  # Likes
  get "like", to: "likes#like_object"
  get "unlike", to: "likes#unlike_object"
  
  # Friends
  get "friends", to: "users#friends_list"
  

end
