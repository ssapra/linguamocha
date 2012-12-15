Linguamocha::Application.routes.draw do
  
  devise_for :users

  get "dashboard/home"

   root to: 'dashboard#home'
  
end
