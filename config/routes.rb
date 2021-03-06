Rails.application.routes.draw do

  resources :locations
  resources :posts
  resources :restaurants
  # devise_for :users
  devise_for :users, controllers: { registrations: "users/registrations" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
end
