Linguamocha::Application.routes.draw do
  
  get "/allskills" => "users#all_skills"
  
  get "/nearby" => "requests#nearby_locations", as: :get_locations
  get "/coordinates" => "requests#coordinates", as: :coordinates
  get "/mycoordinates" => "requests#my_coordinates", as: :my_coordinates
  
  get "/accept/:id" => "requests#accept", as: :accept
  get "/deny/:id" => "requests#deny", as: :deny
  
  post "/search" => "users#search"
  
  resources :requests
  
  post "/message" => "messages#create", as: :message
  
  root to: 'dashboard#home'
  
  devise_for :users  
  get "/:username" => "users#show", as: :user
  get "/:username/edit" => "users#edit", as: :edit_user
  put "/:username" => "users#update", as: :user
  delete "/:username" => "users#destroy", as: :user

end
