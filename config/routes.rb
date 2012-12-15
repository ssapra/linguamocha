Linguamocha::Application.routes.draw do

  root to: 'dashboard#home'
  
  devise_for :users
  
  resources :users

  get "dashboard/home"
  
end
