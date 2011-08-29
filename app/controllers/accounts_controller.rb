class AccountsController < ApplicationController
  
  def index
    @accounts = Account.all
    @title = "All Accounts"
  end
  
  def show
    @account = Account.find(params[:id])
    @title = @account.name
  end
  
  def new
    @account = Account.new
    @title = "Set Up Account"
  end
  
  def create
    @account = Account.new(params[:account])
    
    if (@account.save)
      # @accounts = Account.all
      # @title = "All Accounts"
      # render :index, :flash => { :success => "Account created!" }
      # render :new,  :flash => { :success => "Account created!" }
      redirect_to accounts_path,  :flash => { :success => "Account created!" }      
    else
      render :new, :flash => { :error => "Oops!" } 
      
    end
  end

end
