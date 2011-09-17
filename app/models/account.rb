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

class Account < ActiveRecord::Base
  
  attr_accessible :name, :atype
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }

  validates :atype, :presence   => true,
                    :length   => { :maximum => 50 }


def get_balance(date)    
  jes = Je.get_jes(self.id)
  total = 0
  jes.each { |j| 
# STDERR.puts "loop date is " + date.to_s + " j.date is " + j.date.to_s
       if date >= j.date          
         if j.debit == self.id  
# STDERR.puts "inside if"             
           total += j.amount
         else               
           if j.credit == self.id 
             total -= j.amount
           else    
             raise RangeError
           end
         end
       end
    }
    return total
end   

def state(date)
end

end

