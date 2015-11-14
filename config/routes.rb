Rails.application.routes.draw do
  resources :lectures do
    member do
      get 'enroll'
    end
    collection do
      get 'authorize'
    end
  end
  root to: 'home#index'
  get '/home', to: 'home#show', as: 'user_page'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'lectures', to: 'lectures#index'
end
