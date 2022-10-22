Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :courses
  get 'privacy_policy', to: "static_pages#privacy_policy"
  get 'landing_page', to: "static_pages#landing_page"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "home/index"
  root 'home#index'
  resources :users, only: [:index, :show]
end
