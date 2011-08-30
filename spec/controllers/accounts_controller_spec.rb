require 'spec_helper'


describe AccountsController do
  render_views
  
  before(":each") do
    @a1 = Account.create!(:name => "test1", :atype => "asset"    )
    @a2 = Account.create!(:name => "test2", :atype => "liability")
    @a3 = Account.create!(:name => "test3", :atype => "income"   )
    @a4 = Account.create!(:name => "test4", :atype => "expense"  )
  end


describe "GET 'index'" do
  
  it "should be successful" do
    get :index
    response.should be_success
  end
  
  it "should have the right title" do
    get :index
    response.should have_selector('title', :content => "Chart of Accounts")
  end
  
  it "should have an element for each account" do
    get :index
    @accounts = Account.all
    @accounts.length.should == 4
    
    @accounts.each do |account|
      response.should have_selector('li', :content => account.name)
    end

  end  
  
end

describe "GET 'deletelist'" do
  
  it "should be successful" do
    get :deletelist
    response.should be_success
  end
  
  it "should have the right title" do
    get :deletelist
    response.should have_selector('title', :content => "Choose an Account to Delete")
  end
               
  it "should have an element for each account" do
    get :deletelist
    @accounts = Account.all
    @accounts.length.should == 4
    
    @accounts.each do |account|
      response.should have_selector('li', :content => "Delete " + account.name)
    end
  
  end
    
end


  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Create Account")
    end  
  end

  describe "GET 'destroy'" do           
    
    it "should destroy the account" do
      lambda do
        delete :destroy, :id => @a1
      end.should change(Account, :count).by(-1)
    end
    
    # it "should redirect to the users page" do
    #   delete :destroy, :id => @user
    #   flash[:success].should =~ /destroyed/i
    #   response.should redirect_to(users_path)
    # end    
    
  end



end
