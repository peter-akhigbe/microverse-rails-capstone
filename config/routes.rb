Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :groups do
    resources :entities
  end

  authenticated :user do
    root 'groups#index', as: :authenticated_root
  end

  unauthenticated do
    root to: "splash_screen#index", as: :unauthenticated_root
  end
end
