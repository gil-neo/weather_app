Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "forecasts#index"
  get 'forecasts' => 'forecasts#index'
  post 'forecasts' => 'forecasts#create'
end
