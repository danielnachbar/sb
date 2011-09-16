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
   
   describe "get_balance method" do

     before(:each) do
       @a1 = Account.create!(:name => "test1", :atype => "asset"    )
       @a2 = Account.create!(:name => "test2", :atype => "liability")
       @a3 = Account.create!(:name => "test3", :atype => "income"   )
       @a4 = Account.create!(:name => "test4", :atype => "expense"  )          

       @je1 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                         :amount =>  300, :date => "06/09/2011",  :comment => "I like turtles!" ) 
       @je2 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                         :amount =>  200, :date => "08/09/2011",  :comment => "Why so serious?" )  
                                               
     end

     it "should give the right balance before any journal entries" do
       @a1.get_balance(Date.new(2011,9,5)).should == 0    
     end
     
     it "should give the right balance on the day of a journal entry" do
       @a1.get_balance(Date.new(2011,9,6)).should == 300    
     end     
     
     it "should give the right balance on the day after a journal entry" do
       @a1.get_balance(Date.new(2011,9,7)).should == 300    
     end
     
     it "should give the right balance on the day after a journal entry" do
       @a1.get_balance(Date.new(2011,9,8)).should == 500    
     end     
     
     it "should give the right balance on the day after a journal entry" do
       @a1.get_balance(Date.new(2011,9,9)).should == 500    
     end                      
           
   end



end
