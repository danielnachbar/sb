class AccountsController < ApplicationController
  
  def index
    @accounts = Account.all
    @title = "Chart of Accounts"     
    @alist = accounts_by_type
  end       
  
  def deletelist                   
    @accounts = Account.all
    @title = "Choose an Account to Delete"
  end
  
  def show
    @account = Account.find(params[:id])
    @title = @account.name
  end
  
  def new
    @account = Account.new
    @title = "Create Account"
  end
  
  def create
    @account = Account.new(params[:account])
    
    if (@account.save)                            
      redirect_to account_path(@account.id), :flash => { :success => "Account #{@account.name} created!" }
    else              
      @title = "Create Account"
      render :new
    end
  end    
  
  def destroy
    @account = Account.find(params[:id]) 
    @account.destroy
    redirect_to deletelist_accounts_path, :flash => { :success => "Account destroyed." }         
  end  
  
  private
  
  def accounts_by_type             
    retval = {};                                      
    %w{income expense asset liability}.each do |t|
      retval[t] = Account.where(:atype => t)
    end
    retval
  end
  
end
