Rails.application.routes.draw do
  devise_for :users
  root to: "pokemons#index"

  resources :pokemons, except: [:index] do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:show]
end
