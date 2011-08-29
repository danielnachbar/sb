Sb::Application.routes.draw do
  resources :accounts

  root :to => "pages#home"

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/newaccount', :to => 'accounts#new'
  match '/accountlist', :to => 'accounts#index'

end
