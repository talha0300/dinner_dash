Rails.application.routes.draw do
  resources :categories
  resources :categorizations
  resources :home, only: [:show,:index]
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :items do
    resources:categories,only:[:create,:edit,:update,:new]
  end
  resources :users, only: [:show,:index]
end
