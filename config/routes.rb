Linguamocha::Application.routes.draw do

  root to: 'dashboard#home'
  
  devise_for :users
  
  resources :users

  get "dashboard/home"
  
  match "/allskills" => "users#all_skills"
  
end
