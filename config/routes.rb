Rails.application.routes.draw do
  resources :pages
  resources :hours
  resources :members
  resources :procedures
  resources :users

  get 'admin/logout' => 'sessions#destroy'
  get 'admin/login'     => 'sessions#new'
  get '/login' => 'sessions#redirect'
  get '/admin/change_password' => 'users#change_password'
  namespace :admin do
    resources :pages, :members, :procedures
  end
  get "/admin", to: "admin#index"
#  get "/admin/members", to: "admin#members"
#  get "/admin/procedures", to: "admin#procedures"
#  get "/admin/pages", to: "admin#pages"
#  get "admin/members/:id/edit", to: "admin#members_edit"


  #get "/about", to: "dental#about"


  root "application#index"

  # sign up page with form:
#  get 'admin/users/new' => 'users#new', as: :new_user

  # create (post) action for when sign up form is submitted:
  post 'users' => 'users#create'




  # create (post) action for when log in form is submitted:
  post 'admin/login'    => 'sessions#create'

  # delete action to log out:


  get "/:site/members", to: "members#index"
  get "/:site/procedures", to: "procedures#index"
  get "/:site/members/:id", to: "members#show"
  get "/:site/procedures/:id", to: "procedures#show"
  get "/:pages/:id", to: "application#pages"
  get "/:site", to: "application#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
