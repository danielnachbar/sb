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
      response.should have_selector('li', :content => account.name.titleize)
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
      response.should have_selector('li', :content => "Delete " + account.name.titleize)
    end
  
  end
    
end

describe "GET 'updatelist'" do
  
  it "should be successful" do
    get :updatelist
    response.should be_success
  end
  
  it "should have the right title" do
    get :updatelist
    response.should have_selector('title', :content => "Choose an Account to Edit")
  end
                 
  it "should have an element for each account" do
    get :updatelist
    @accounts = Account.all
    @accounts.length.should == 4
    
    @accounts.each do |account|
      response.should have_selector('li', :content => "Edit " + account.name.titleize)
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

  describe "POST 'create'" do 
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :atype => "" }
      end
      
      it "should have the right title" do
        post :create, :account => @attr
        response.should have_selector('title', :content => "Create Account")
      end  
      
      # it "should destroy the account" do
      #   lambda do
      #     delete :destroy, :id => @a1
      #   end.should change(Account, :count).by(-1)
      # end         
      
      
      # 
      # it "should render the 'new' page" do
      #   post :create, :user => @attr
      #   response.should render_template('new')
      # end
      # 
      # it "should not create a user" do
      #   lambda do
      #     post :create, :user => @attr
      #   end.should_not change(User, :count)
      # end           
    end
  end


  describe "GET 'edit'" do
    
    it "should be successful" do
      get :edit, :id => @a1
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @a1
      response.should have_selector('title', :content => "Edit "+ @a1.name.titleize)
    end                       
    
  end

  describe "PUT 'update'" do
      
  
    # describe "failure" do
    #   
    #   before(:each) do
    #     @attr = { :name => "", :atype => "" }
    #   end
    #   
    #   it "should render the 'edit' page" do
    #     put :update, :id => @user, :user => @attr
    #     response.should render_template('edit')
    #   end
    #   
    #   it "should have the right title" do
    #     put :update, :id => @user, :user => @attr
    #     response.should have_selector('title', :content => "Edit user")
    #   end
    # end 
             
    describe "success" do
      
      before(:each) do
        @attr = { :name => "test11", :atype => "income"}
      end
      
      it "should change the accounts's attributes" do
        put :update, :id => @a1, :account => @attr
        @a1.reload
        @a1.name.should  == @attr[:name]
        @a1.atype.should == @attr[:atype]
      end
      
      it "should have a flash message" do
        put :update, :id => @a1, :user => @attr
        flash[:success].should =~ /Updated/
      end                      
    end               # success
    
                                
  end # PUT update


  describe "GET 'destroy'" do           

    it "should have the right title" do
      get :deletelist
      response.should have_selector('title', :content => "Choose an Account to Delete")
    end

    
    it "should destroy the account" do
      lambda do
        delete :destroy, :id => @a1
      end.should change(Account, :count).by(-1)
    end
    
    
  end



end
