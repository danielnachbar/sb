
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
#

class JeValidator < ActiveModel::Validator
  # implement the method where the validation logic must reside
  def validate(je)
    # do my validations on the record and add errors if necessary
    #record.errors[:base] << "This is some custom error message"
    # record.errors[:first_name] << "This is some complex validation"     
    
    if Account.find_by_id(je.credit).nil?       
      je.errors[:credit] << "Account #{je.credit} invalid"      
    end      
    
    if Account.find_by_id(je.debit).nil?       
      je.errors[:debit] << "Account #{je.debit} invalid"      
    end    
    
  end
end
                                                          
class Je < ActiveRecord::Base            
  
  
  attr_accessible :credit, :debit, :amount, :comment
  
  validates :credit, :presence => true
  validates_numericality_of :credit, :greater_than_or_equal_to => 1   
  
  validates_with JeValidator  
     
  validates :debit, :presence => true
  validates_numericality_of :debit, :greater_than_or_equal_to => 1
  validates :amount, :presence => true
  validates_numericality_of :amount, :greater_than_or_equal_to => 0     
  validates :comment, :length => {:maximum => 255}

end