Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pigeons
  post "pigeons/:id/book", to: "rentals#create", as: :book
  resources :profiles, only: [:show]

  resources :rentals do
    resources :reviews
  end
end
