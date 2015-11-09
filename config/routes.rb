Rails.application.routes.draw do
  resources :lectures do
    member do
      get 'enroll'
    end
  end
  root :to => 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'lectures', to: 'lectures#index'
end
