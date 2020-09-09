Rails.application.routes.draw do
  resources :categories
  resources :categorizations
  resources :home, only: [:show,:index]
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "home#index"
  resources :items 
  resources :users, only: [:show,:index]
end
