Sb::Application.routes.draw do
        
  get "books/new"
  
  resources :reports do
    get "balancesheet", :on => :collection
    get "pandl"       , :on => :collection
  end


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
