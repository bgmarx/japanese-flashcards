Rails.application.routes.draw do
  root to: 'home#index'

  resources :kanji,        only: [:new, :show, :index]
  resources :vocabularies, only: [:new, :show, :index]
end
