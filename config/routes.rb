Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "shorten", to: "urls#generate_slug"
  get "shorten/:slug", to: "urls#find_original"
  put "shorten/:slug", to: "urls#update_slug"
  delete "shorten/:slug", to: "urls#delete_slug"
  get "shorten/:slug/stats", to: "urls#get_stats"

  # Defines the root path route ("/")
  # root "posts#index"
end
