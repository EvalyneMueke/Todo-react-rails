Rails.application.routes.draw do
  resources :tasks
  resources :users
  post "/login", to: "users#login"
  get "/users/tasks", to: "users#get_all_user_tasks"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
