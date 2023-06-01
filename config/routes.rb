Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pigeons
  post "pigeons/:id/book", to: "rentals#create", as: :book
  resources :profiles, only: [:show]
  post "rentals/:id/accept", to: "rentals#accept", as: :rental_accept

  resources :rentals do
    resources :reviews
  end
end
