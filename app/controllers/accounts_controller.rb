class AccountsController < ApplicationController
  def new
    @account = Account.new
    @title = "Set Up Account"
  end
  
  def create
    @account = Account.new(params[:account])
    
    if (@account.save)
      redirect_to root_path, :flash => { :success => "Account created!" }
    else
      redirect_to root_path, :flash => { :error => "Oops!" }
    end
  end

end
