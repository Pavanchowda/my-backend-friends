Rails.application.routes.draw do
  # devise_for :models
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      devise_for :models, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
      resources :friends do
        member do
          post 'upload_photo'
        end
        collection do
          get 'export_excel'
          get 'export_pdf'
        end
      end
      post 'forgot-password', to: 'passwords#forgot_password'
      post 'friends/upload_photo_test', to: 'friends#upload_photo_test'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]
    end
  end

  # Define your other routes as needed
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  #root "friends#index"
end
