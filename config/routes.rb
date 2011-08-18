Sb::Application.routes.draw do
  get "accounts/new"

  root :to => "pages#home"

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'

end
