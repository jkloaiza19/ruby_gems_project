# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :courses
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'landing_page', to: 'static_pages#landing_page'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'home/index'
  get 'home/activity'
  root 'home#index'
  delete 'users/:id', to: 'users#destroy'
  resources :users, only: %i[index show edit destroy update]
  resources :lessons
end
