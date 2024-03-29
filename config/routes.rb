Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :discussions do
    resources :posts, except: [:index], module: :discussions

    collection do
      get 'category/:id', to: 'categories/discussions#index', as: :category
    end

    resources :notifications, only: :create, module: :discussions
  end
  root 'main#index'
end
