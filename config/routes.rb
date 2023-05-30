Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pigeons
  resources :rentals, only: %i[show destroy]
  post "pigeons/:id/book", to: "rentals#create", as: :book
end
