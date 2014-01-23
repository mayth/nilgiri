Nilgiri::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :players, controllers: {
    sessions: 'players/sessions',
    registrations: 'players/registrations',
    passwords: 'players/passwords'
  }
  root to: 'home#index'
  resources :scores
  resources :musics
  resources :machines, only: [:index, :show]
  resources :seasons, only: [:index, :show]
  resources :posts
  resources :players, only: [:index, :show]
end
