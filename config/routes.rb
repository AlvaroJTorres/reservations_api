Rails.application.routes.draw do
  use_doorkeeper

  resources :restaurants do
    resources :tables
    resources :office_hours
    resources :calendars
  end
  
  resources :users
  resources :reservations, only: %i[create]
  get 'reservations/:customer_code', to: 'reservations#show'
  patch 'reservations/:customer_code', to: 'reservations#update'
  delete 'reservations/:customer_code', to: 'reservations#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
