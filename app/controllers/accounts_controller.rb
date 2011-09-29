class AccountsController < ApplicationController
  
  def index
    @title = "Chart of Accounts"     
    # @alist = accounts_by_type     
    @alist = Books.current.state[:children]
#    STDERR.puts @alist.inspect   
  end       

  def updatelist                   
    @title = "Choose an Account to Edit" 
    #@alist = accounts_by_type 
    @alist = Books.current.state[:children]       
  end               
  
  def deletelist                   
    @title = "Choose an Account to Delete" 
   # @alist = accounts_by_type
   @alist = Books.current.state[:children]              
  end
  
  def show
    @account = Account.find(params[:id])
    @title = @account.name   
    @state = @account.state
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
  
  def edit   
    @account = Account.find(params[:id])
    @title = "Edit " + @account.name.titleize    
  end      

  def update    
       
    @account = Account.find(params[:id])      
    if @account.update_attributes(params[:account])  
                                
      redirect_to @account, :flash => { :success => "Account #{@account.name.titleize} Updated!" }
    else
      @title = "Edit Account"
      render :edit
    end    
  end  
  
  def destroy
    @account = Account.find(params[:id]) 
    @account.destroy
    redirect_to accounts_path, :flash => { :success => "Account destroyed." }         
  end  
  
end
