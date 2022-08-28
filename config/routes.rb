Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :users, only: [:show] do
    # nested resource for items
    resources :items, only: [:show, :index, :create]
  end
end
