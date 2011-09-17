require 'spec_helper'



# == Schema Information
#
# Table name: books
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

        
describe Books do
  describe "current_books method" do
    it "should return an object of class books"  do 
      Books.current.class.to_s == "Books"
    end 
  end 
  
  describe "state method" do    
    it "should return an hash with 4 elements whose values to arrays"  do
      s = Books.state(Date.new(2011,9,8))
      s.class.to_s.should == "Hash"
      # s["income"   ].should_not be_nil
      # s["expense"  ].should_not be_nil
      # s["asset"    ].should_not be_nil
      # s["liability"].should_not be_nil
      # 
      # s["income"   ].class.to_s.should == "Hash"
      # s["expense"  ].class.to_s.should == "Hash"
      # s["asset"    ].class.to_s.should == "Hash"
      # s["liability"].class.to_s.should == "Hash"               
      
      
    end
  end 

end