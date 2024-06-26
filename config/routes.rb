Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  ActiveAdmin.routes(self)
  root to: "plants#index"
  resources :plants, only: [:index, :show] do
    collection do
      get "search"
    end
  end
  resources :orders, only: [:index, :show]
  resources :plant_types, only: [:show]
  resources :cart, only: [:index, :create, :destroy] do
    post 'invoice', on: :collection
  end

  scope "/checkout" do
    get "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
