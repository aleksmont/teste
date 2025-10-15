Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  get '/profiles' => 'profiles#index', as: :profiles
  get '/profiles/new' => 'profiles#new', as: :profiles_new
  get '/profiles/:uuid' => 'profiles#show', as: :profiles_show
  post '/profiles/:uuid/delete' => 'profiles#destroy', as: :profiles_destroy
  post '/profiles' => 'profiles#create'
  post '/profile_reload' => 'profiles#reload'

  mount RailsUrlShortener::Engine, at: "/"
end
