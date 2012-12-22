Linguamocha::Application.routes.draw do
  
  get "/allskills" => "users#all_skills"

  get "/requests" => "requests#index", as: :requests
  get "/requests/new" => "requests#new", as: :new_request
  post "/request" => "requests#create", as: :request
  get "/request/:id" => "requests#show", as: :request
  
  
  root to: 'dashboard#home'
  
  devise_for :users  
  get "/:username" => "users#show", as: :user
  get "/:username/edit" => "users#edit", as: :edit_user
  put "/:username" => "users#update", as: :user
  delete "/:username" => "users#destroy", as: :user

  
end
