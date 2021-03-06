
# == Schema Information
#
# Table name: jes
#
#  id         :integer         not null, primary key
#  debit      :integer
#  credit     :integer
#  amount     :integer
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  date       :date
#




require 'spec_helper'

describe Je do

    before(:each) do
      @a1 = Account.create!(:name => "test1", :atype => "asset"    )
      @a2 = Account.create!(:name => "test2", :atype => "liability")
      @a3 = Account.create!(:name => "test3", :atype => "income"   )
      @a4 = Account.create!(:name => "test4", :atype => "expense"  )
                
      @a5 = Account.create!(:name => "test5", :atype => "expense"  )           # never has a Je
      
      @attr = { 
        :credit => @a1.id,
        :debit => @a2.id,
        :amount =>  300,
        :date => "09/06/2011",         
        :comment => "I like turtles!"
      }    
  
    end


    it "should create a new instance given a valid attribute" do
      j = Je.create!(@attr)
      j.should be_valid    
    end         


    it "should save the credit account correctly" do
      j2 = Je.create!(@attr)
      j2.should be_valid 
      j2.credit.should == @attr[:credit]
    end


    it "should save the debit account correctly" do
      j2 = Je.create!(@attr)
      j2.should be_valid 
      j2.debit.should == @attr[:debit]
    end


    it "should save the amount correctly" do
      j2 = Je.create!(@attr)
      j2.should be_valid 
      j2.amount.should == @attr[:amount]
    end


    it "should save the date correctly" do
      j2 = Je.create!(@attr)
      j2.should be_valid
      d2 = Date.parse(@attr[:date])
      j2.date.should ==  d2
    end

    it "should save the comment correctly" do
      j2 = Je.create!(@attr)
      j2.should be_valid 
      j2.comment.should eql @attr[:comment]
    end         


    it "should require the credit account be present" do
      j2 = Je.create(@attr.merge(:credit => nil))
      j2.should_not be_valid
    end         
       
  
    it "should require a credit account id greater than zero" do
      j2 = Je.create(@attr.merge(:credit => 0))
      j2.should_not be_valid
    end
      
    
    it "should require a valid credit account id" do
      j2 = Je.create(@attr.merge(:credit => 9999))
      j2.should_not be_valid
    end              
             

    it "should require the debit account be present" do
      j2 = Je.create(@attr.merge(:debit => nil))
      j2.should_not be_valid
    end         
       
      
    it "should require a debit account id greater than zero" do
      j2 = Je.create(@attr.merge(:debit => 0))
      j2.should_not be_valid
    end
         
    
    it "should require a debit credit account id" do
      j2 = Je.create(@attr.merge(:debit => 9999))
      j2.should_not be_valid
    end        

     
    it "should require a that credit and debit accounts are different" do
      j2 = Je.create(@attr.merge(:debit => @a1.id))
      j2.should_not be_valid
    end
 

    it "should require the amount to be present" do
      j2 = Je.create(@attr.merge(:amount => nil))
      j2.should_not be_valid
    end

    it "should require the amount to be greater than or equal to zero" do
      j2 = Je.create(@attr.merge(:amount => -1))
      j2.should_not be_valid
    end    

    it "should require the date to be present" do
      j2 = Je.create(@attr.merge(:date => nil))
      j2.should_not be_valid
    end


    it "should require that comments are less than 256 chars" do
      j2 = Je.create(@attr.merge(:comment => "x"*256))
      j2.should_not be_valid
    end 

   describe "get_jes method" do 
     
     before (:each) do

       @je1 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                         :amount =>  200, :date => "09/08/2011",  :comment => "Why so serious?" )
                         
       @je2 = Je.create!(:debit => @a3.id, :credit => @a4.id,
                         :amount =>  200, :date => "09/07/2011",  :comment => "Can't see me!" )
              
       @je3 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                         :amount =>  300, :date => "09/06/2011",  :comment => "I like turtles!" )  
     end
                     
     it "should return the right number of journal entries for multiple debit jes" do
          Je.get_jes(@a1.id).length.should == 2
     end

     it "should return the right number of journal entries for multiple credit jes" do
          Je.get_jes(@a2.id).length.should == 2
     end

     it "should return the right number of journal entries for a single debit je" do
          Je.get_jes(@a3.id).length.should == 1
     end
     
     it "should return the right number of journal entries for a single credit je" do
          Je.get_jes(@a4.id).length.should == 1
     end     
     
     it "should return the right number of journal entries for an account with no jes" do
          Je.get_jes(@a5.id).length.should == 0
     end             
     
   end
    
end

