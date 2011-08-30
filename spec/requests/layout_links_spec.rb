 require 'spec_helper'

describe "LayoutLinks" do    
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
                
  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end     
  
   it "should have the right links on the layout" do
    visit root_path
    response.should have_selector('title', :content => "Home")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")     

  end
end          

describe "Home Page Links" do       
  it "should have a working link to the Chart of Accounts Page" do
    visit root_path
    click_link "Chart of Accounts"
    response.should have_selector('title', :content => "Chart of Accounts")       
  end  
 
  it "should have a working link to the Create Account Page" do
    visit root_path     
    click_link "Create Account"
    response.should have_selector('title', :content => "Create Account")      
  end             

 it "should have a working link to the Delete Account List Page" do
   visit root_path     
   click_link "Delete Account"
   response.should have_selector('title', :content => "Choose an Account to Delete")      
 end
  
end