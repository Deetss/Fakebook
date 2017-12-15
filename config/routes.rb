Rails.application.routes.draw do
  root 'static_pages#home'
  put 'accept', to: 'relationships#accept'
  get 'request_friendship', to: 'relationships#request_friendship'
  get 'requests', to: 'relationships#index'
  delete 'requests', to: 'relationships#destroy'
  devise_for :users
  resources :users, only: [:show, :edit]
end
