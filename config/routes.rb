Rails.application.routes.draw do
  devise_for :users
  resources :discussions
  root 'main#index'
end
