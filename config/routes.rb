Linguamocha::Application.routes.draw do
  
  get "/allskills" => "users#all_skills"
  
  get "/nearby" => "requests#nearby_locations", as: :get_locations
  get "/coordinates" => "requests#coordinates", as: :coordinates
  get "/mycoordinates" => "requests#my_coordinates", as: :my_coordinates
  
  get "/accept/:id" => "requests#accept", as: :accept
  get "/deny/:id" => "requests#deny", as: :deny
  
  get "/confirm/:id" => "requests#confirm", as: :confirm
  get "/deny/:id" => "requests#deny_request", as: :deny_request

  post "/search" => "users#search"
  
  resources :requests
  
  get "/review/:id" => "reviews#new", as: :review
  post "/review/:id" => "reviews#create"
  
  post "/message" => "messages#create", as: :message
  
  root to: 'dashboard#home'
  
  post "/full_search" => "users#search", as: :search
  get "/full_search" => "users#search_form", as: :full_search
  
  devise_for :users  
  
  get "/:username" => "users#show", as: :user
  get "/:username/edit" => "users#edit", as: :edit_user
  put "/:username" => "users#update", as: :user
  delete "/:username" => "users#destroy", as: :user

end
