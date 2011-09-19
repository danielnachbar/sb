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
     
    before (:each) do
      @a1 = Account.create!(:name => "test1", :atype => "asset"    )
      @a2 = Account.create!(:name => "test2", :atype => "liability")
      @a3 = Account.create!(:name => "test3", :atype => "income"   )
      @a4 = Account.create!(:name => "test4", :atype => "expense"  )
              
      @a5 = Account.create!(:name => "test5", :atype => "expense"  )           # never has a Je
    
      @je1 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                        :amount =>  200, :date => "08/09/2011",  :comment => "Why so serious?" )
                      
      @je2 = Je.create!(:debit => @a3.id, :credit => @a4.id,
                        :amount =>  200, :date => "07/09/2011",  :comment => "Can't see me!" )
           
      @je3 = Je.create!(:debit => @a1.id, :credit => @a2.id,
                        :amount =>  300, :date => "06/09/2011",  :comment => "I like turtles!" )           
    end       
    
    it "should return an hash with 4 elements whose values correspond to the 4 account types"  do
      s = Books.current.state(Date.new(2011,9,7))
      s.class.to_s.should == "Hash"
      
      s[:children].should_not be_nil
      
      c = s[:children]
      
      c["income"   ].should_not be_nil  
      c["expense"  ].should_not be_nil
      c["asset"    ].should_not be_nil
      c["liability"].should_not be_nil    

      c["income"   ].class.to_s.should == "Hash"
      c["expense"  ].class.to_s.should == "Hash"
      c["asset"    ].class.to_s.should == "Hash"
      c["liability"].class.to_s.should == "Hash"       
      
      s[:balance].should == 0
      
    end

    describe "the balances beforehand" do   
      before (:each) do       
        @s = Books.current.state(Date.new(2011,9,5))
        @s.class.to_s.should == "Hash"

        @c = @s[:children]
        @i = @c["income"]
        @e = @c["expense"]
        @a = @c["asset"]
        @l = @c["liability"]
      end   
     
     it "should have the right balance for income" do       
       @i[:balance].should == 0
     end 

     
     it "should have the right balance for expense" do       
       @e[:balance].should == 0
     end

     
     it "should have the right balance for assets" do       
       @a[:balance].should == 0
     end
 
     it "should have the right balance for liability" do       
       @l[:balance].should == 0
     end

      
    end

    
    describe "the balances in the middle" do   
      before (:each) do       
        @s = Books.current.state(Date.new(2011,9,7))
        @s.class.to_s.should == "Hash"

        @c = @s[:children]
        @i = @c["income"]
        @e = @c["expense"]
        @a = @c["asset"]
        @l = @c["liability"]
      end   
     
     it "should have the right balance for income" do       
       @i[:balance].should == 200
     end 

     
     it "should have the right balance for expense" do       
       @e[:balance].should == -200
     end

     
     it "should have the right balance for assets" do       
       @a[:balance].should == 300
     end
 
     it "should have the right balance for liability" do       
       @l[:balance].should == -300
     end

      
    end

    describe "the balances at the end" do   
      before (:each) do       
        @s = Books.current.state(Date.new(2011,9,8))
        @s.class.to_s.should == "Hash"

        @c = @s[:children]
        @i = @c["income"]
        @e = @c["expense"]
        @a = @c["asset"]
        @l = @c["liability"]
      end   
     
     it "should have the right balance for income" do       
       @i[:balance].should == 200
     end 

     
     it "should have the right balance for expense" do       
       @e[:balance].should == -200
     end

     
     it "should have the right balance for assets" do       
       @a[:balance].should == 500
     end
 
     it "should have the right balance for liability" do       
       @l[:balance].should == -500
     end

      
    end
    
  end 

end