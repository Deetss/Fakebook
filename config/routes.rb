Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users, only: [:show, :edit]
  put 'accept', to: 'relationships#accept'
  get 'requests', to: 'relationships#index'
  devise_for :users
end
