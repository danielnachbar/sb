require 'spec_helper'


# == Schema Information
#
# Table name: accounts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  atype      :string(255)
#  created_at :datetime
#  updated_at :datetime
#



describe Account do
  

   before(:each) do
     @attr = { 
       :name => "bank",
       :atype => "asset"
     }
   end
 
 
   it "should create a new instance given a valid attribute" do
     a = Account.create!(@attr)
     a.should be_valid    
   end
 
   it "should require a name" do
     no_name_account = Account.new(@attr.merge(:name => ""))
     no_name_account.should_not be_valid
   end
   
   it "should reject names that are too long" do
     long_name = "a" * 51
     long_name_account = Account.new(@attr.merge(:name => long_name))
     long_name_account.should_not be_valid
   end   


 it "should require a atype" do
   no_atype_account = Account.new(@attr.merge(:atype => ""))
   no_atype_account.should_not be_valid
 end
 
 it "should reject atypes that are too long" do
   long_atype = "a" * 51
   long_atype_account = Account.new(@attr.merge(:atype => long_atype))
   long_atype_account.should_not be_valid
 end
 
   # it "should now allow accessing the id" do
   #   a = Account.create!(@attr)
   #   a.id = 123
   #   a.save
   #   a.id should_not be_equal 123
   # end

   it "should reject duplicate names" do
     Account.create!(@attr)
     user_with_duplicate_name = Account.new(@attr)
     user_with_duplicate_name.should_not be_valid
   end

   it "should reject names identical up to case" do
     upcased_name = @attr[:name].upcase
     Account.create!(@attr.merge(:name => upcased_name))
     user_with_duplicate_name = Account.new(@attr)
     user_with_duplicate_name.should_not be_valid
   end 

end
