Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  use_doorkeeper

  namespace :customer do
    resources :restaurants, only: %i[index] do
      resources :tables, only: %i[index]
    end
    resources :reservations, only: %i[create]
  end
  
  namespace :admin do
    resources :restaurants, only: %i[create update destroy]
    resources :users, only: %i[index create update]
  end

  namespace :manager do
    resources :restaurants do
      resources :tables, only: %i[create destroy]
      resources :office_hours, only: %i[create update destroy]
      resources :calendars, only: %i[create update destroy]
    end

    get 'reservations/:customer_code', to: 'reservations#show'
    patch 'reservations/:customer_code', to: 'reservations#update'
    delete 'reservations/:customer_code', to: 'reservations#destroy'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
