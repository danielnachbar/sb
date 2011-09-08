require 'spec_helper'

describe Je do

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


    it "should create a new instance given a valid attribute" do
      j = Je.create!(@attr)
      j.should be_valid    
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
 

    it "should require the amount to be present" do
      j2 = Je.create(@attr.merge(:amount => nil))
      j2.should_not be_valid
    end

    it "should require the amount to be greater than or equal to zero" do
      j2 = Je.create(@attr.merge(:amount => -1))
      j2.should_not be_valid
    end    

    it "should require that comments are less than 256 chars" do
      j2 = Je.create(@attr.merge(:comment => "x"*256))
      j2.should_not be_valid
    end
    
  # 
  #   it "should reject names that are too long" do
  #     long_name = "a" * 51
  #     long_name_account = Account.new(@attr.merge(:name => long_name))
  #     long_name_account.should_not be_valid
  #   end   
  # 
  # 
  # it "should require a atype" do
  #   no_atype_account = Account.new(@attr.merge(:atype => ""))
  #   no_atype_account.should_not be_valid
  # end
  # 
  # it "should reject atypes that are too long" do
  #   long_atype = "a" * 51
  #   long_atype_account = Account.new(@attr.merge(:atype => long_atype))
  #   long_atype_account.should_not be_valid
  # end
  # 
  #   # it "should now allow accessing the id" do
  #   #   a = Account.create!(@attr)
  #   #   a.id = 123
  #   #   a.save
  #   #   a.id should_not be_equal 123
  #   # end
  # 
  #   it "should reject duplicate names" do
  #     Account.create!(@attr)
  #     user_with_duplicate_name = Account.new(@attr)
  #     user_with_duplicate_name.should_not be_valid
  #   end
  # 
  #   it "should reject names identical up to case" do
  #     upcased_name = @attr[:name].upcase
  #     Account.create!(@attr.merge(:name => upcased_name))
  #     user_with_duplicate_name = Account.new(@attr)
  #     user_with_duplicate_name.should_not be_valid
  #   end           


end


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

