Rails.application.routes.draw do
  root :to => 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
end
