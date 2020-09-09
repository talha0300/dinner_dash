Rails.application.routes.draw do
  resources :categories
  resources :carts, only:[:show]
  resources :categorizations
  resources :home, only: [:show,:index]
  devise_for :users, controllers: {sessions: 'users/sessions',registrations:'users/registrations'}

  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
  end

  root to: "home#index"
  resources :items
  resources :users, only: [:show,:index]
end
