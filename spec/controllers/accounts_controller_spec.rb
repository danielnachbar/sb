require 'spec_helper'


describe AccountsController do
  render_views
  
  before(":each") do
    Account.create!(:name => "test1", :atype => "asset"    )
    Account.create!(:name => "test2", :atype => "liability")
    Account.create!(:name => "test3", :atype => "income"   )
    Account.create!(:name => "test4", :atype => "expense"  )
  end


describe "GET 'index'" do
  
  it "should be successful" do
    get :index
    response.should be_success
  end
  
  it "should have the right title" do
    get :index
    response.should have_selector('title', :content => "All Accounts")
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



  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Set Up Account")
    end  
  end




end
