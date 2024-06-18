Rails.application.routes.draw do
   devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index" 
  resources :books do
    member do
      post 'rent'
    end
  end
  resources :rentals, only: [:index, :show] do
    member do
      put 'return'
    end
  end
  get 'rented_books', to: 'rentals#admin_index', as: 'rented_books' 
end
