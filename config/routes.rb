Rails.application.routes.draw do
  # get 'static_pages/landing_page'
  # get 'static_pages/privacy_policy'
  get 'privacy_policy', to: "static_pages#privacy_policy"
  get 'landing_page', to: "static_pages#landing_page"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#landing_page"
end
