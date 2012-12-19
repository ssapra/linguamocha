Linguamocha::Application.routes.draw do

  get "my_skills/new"

  get "my_skills/destroy"

  root to: 'dashboard#home'
  
  devise_for :users  
  get "/:username" => "users#show", as: :user
  get "/:username/edit" => "users#edit", as: :edit_user
  put "/:username" => "users#update", as: :user
  delete "/:username" => "users#destroy", as: :user
  
  # resources :user
  
  # match "/allskills" => "users#all_skills"
  
end
