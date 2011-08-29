require 'spec_helper'


describe AccountsController do
  render_views
  
  before(":each") do
    Account.new(:name => "test1", :atype => "asset"    ).save
    Account.new(:name => "test2", :atype => "liability").save
    Account.new(:name => "test3", :atype => "income"   ).save
    Account.new(:name => "test4", :atype => "expense"  ).save
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
