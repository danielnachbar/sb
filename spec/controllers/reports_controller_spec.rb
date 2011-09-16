require 'spec_helper'

describe ReportsController do 
  render_views

  describe "GET 'balancesheet'" do
    it "should be successful" do
      get 'balancesheet'
      response.should be_success
    end   
    
    it "should have the right title" do
      get 'balancesheet'
      response.should have_selector( "title", :content => "Balance Sheet")
        
    end

  end

end
