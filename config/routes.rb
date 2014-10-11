Rails.application.routes.draw do
  resources :cards, only: [:new, :show, :index]
end
