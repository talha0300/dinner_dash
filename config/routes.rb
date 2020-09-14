Rails.application.routes.draw do
  resources :categories
  resources :carts, only:[:show]
  resources :categorizations
  resources :home, only: [:show,:index] do
    collection do
      get 'record_not_found'
    end
  end
  devise_for :users, controllers: {sessions: 'users/sessions',registrations:'users/registrations'}

  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
  end

  root to: "home#index"
  resources :items do
    resources:carts, only:[:create,:destroy]
  end
  resources :users, only: [:show,:index]
end
