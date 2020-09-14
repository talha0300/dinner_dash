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


  resources :orders do
    collection do
      get 'all_orders'
    end
    member do
      get 'single_order'
      put 'mark_complete_order'
      put 'cancel_order'
      put 'mark_paid_order'
    end
    
  end

  root to: "items#index"
  resources :items do
    resources:carts, only:[:create,:destroy]
    member do
      post 'toggle_retire'
    end
    member do
      post 'filter'
    end
  end
  resources :users, only: [:show,:index]
end
