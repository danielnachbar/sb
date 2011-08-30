require 'spec_helper'

describe PagesController do

  render_views
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
#      response.should have_selector("title", :content => "/home/i")
#      response.should have_selector("title") contain(/home/i)
      
      response.should have_selector("title") do |title|
        title.should contain(/home/i)
      end
    end
    
    it "should have a link to the Accounts Page" do
      get 'home'
      response.should have_selector('a', :href => accounts_path,
                                         :content => "Chart of Accounts")                                               
    end        
    
    it "should have a link to the Create Account" do
      get 'home'
      response.should have_selector('a', :href => new_account_path,
                                         :content => "Create Account")                                               
    end    
    
    it "should have a link to the Delete Account" do
      get 'home'
      response.should have_selector('a', :href => '/accounts/deletelist',
                                         :content => "Delete Account")                                               
    end   
     
    
    
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title") do |title|
        title.should contain(/contact/i)
      end 
    end   
    
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_selector("title") do |title|
        title.should contain(/about/i)
      end 
    end  
  end

end
