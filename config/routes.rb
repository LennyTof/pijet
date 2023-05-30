Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pigeons
  resources :profiles, only: [:show]
end
