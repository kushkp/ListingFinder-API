Rails.application.routes.draw do
  resources :listings, only: [:index], defaults: { format: :json }
end
