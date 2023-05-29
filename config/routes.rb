Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "pigeon/:id", to: "pigeon#show"
end
