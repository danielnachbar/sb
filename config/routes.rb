Sb::Application.routes.draw do
        
  get "books/new"

  get "reports/balancesheet"

  resources :jes  do
    get 'deletelist', :on => :collection       
    get 'updatelist', :on => :collection           
  end

  resources :accounts do
    get 'deletelist', :on => :collection       
    get 'updatelist', :on => :collection           
  end

  root :to => "pages#home"

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  
end
