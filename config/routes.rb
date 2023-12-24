Rails.application.routes.draw do
  devise_for :users
  resources :discussions, only: %i[index new create destroy]
  root 'main#index'
end
