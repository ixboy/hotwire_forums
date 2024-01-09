Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :discussions do
    resources :posts, except: [:index], module: :discussions
  end
  root 'main#index'
end
