class AccountsController < ApplicationController
  
  def index
    @accounts = Account.all
    @title = "All Accounts"      
    STDERR.puts "params is #{defined? params}"
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
      redirect_to account_path(@account.id), :flash => { :success => "Account #{@account.name} created!" }
    else
      render :new, :flash => { :error => "Oops!" } 
      
    end
  end

end
