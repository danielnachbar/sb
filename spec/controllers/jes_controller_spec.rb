require 'spec_helper'

describe JesController do
   
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end         
    
    it "should have the right title" do        
      get 'new'
      response.should have_selector('title', :content => "New Journal Entry")
    end          
         
  end    # GET 'new'
  

  describe "POST 'create'" do 

    describe "failure" do
      
      before(:each) do
        @attr = { :credit => 0, :debit => 0, :amount => -1 }
      end
                        
      it "should render the 'new' page" do
        post :create, :je => @attr
        response.should render_template(:new)
      end            
      
      it "should have the right title" do
        post :create, :je => @attr
        response.should have_selector('title', :content => "New Journal Entry")
      end           
      
      it "should not create an account" do  
        lambda do
          post :create, :je => @attr
        end.should change(Je, :count).by(0)
      end                          
      
        
    end      # create failure  

             
    describe "success" do
      
      before(:each) do
        @a1 = Account.create!(:name => "test1", :atype => "asset"    )
        @a2 = Account.create!(:name => "test2", :atype => "liability")
        @a3 = Account.create!(:name => "test3", :atype => "income"   )
        @a4 = Account.create!(:name => "test4", :atype => "expense"  )          

        @attr = { 
          :credit => @a1.id,
          :debit => @a2.id,
          :amount =>  300,         
          :comment => "I like turtles!"
        }
      end
          
      it "should create an account" do
        lambda do
          post :create, :je => @attr
        end.should change(Je, :count).by(1)
      end
         
               
      it "should redirect to the account show page" do
        post :create, :je => @attr
        response.should redirect_to(je_path(assigns(:je)))
      end             
      
      it "should have a flash message" do
        post :create, :je => @attr
        flash[:success].should =~ /Created/i
      end                      
    end               # success                  
    
                                                             
 
    
  end      # POST create  

end
