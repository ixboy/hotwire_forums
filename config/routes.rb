Rails.application.routes.draw do
  devise_for :users
  resources :discussions do
    resources :posts, except: [:index], module: :discussions
  end
  root 'main#index'
end
