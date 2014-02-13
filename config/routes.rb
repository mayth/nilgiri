Nilgiri::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :players, controllers: {
    sessions: 'players/sessions',
    registrations: 'players/registrations',
    passwords: 'players/passwords'
  }
  root to: 'home#index'
  resources :scores, only: [:index, :new, :create, :destroy]
  resources :musics, only: [:index, :show]
  resources :machines, only: [:index, :show] do
    resources :musics, only: [:index, :show]
  end
  resources :seasons, only: [:index, :show]
  resources :posts
  resources :players, only: [:index, :show]
end
