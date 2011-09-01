require 'spec_helper'

describe JesController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end         
    
    # it "should have the right title" do
    # end               
  end

end
