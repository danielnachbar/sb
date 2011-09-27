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


  def balance(date = Date.new(Time.now.year, Time.now.month, Time.now.day))    
    balance_from_jes(Je.get_jes(self.id),date)
  end

  def state(date = Date.new(Time.now.year, Time.now.month, Time.now.day))
    c = child_hash         
    {:name => self.name,
     :obj => self,
     :children => c,
     :balance => balance_from_jes(c,date) 
      }
  end   

  private 

  def child_hash     
    r = {}
    Je.get_jes(self.id).each { |j|
       r[j.id] = j 
    }             
    return r
  end       

 
  def balance_from_jes(jes,indate)
    total = 0
    case jes.class.to_s       
    when "Hash"
        je_array = jes.values
    when "Array"
      je_array = jes
    else
      raise ArgumentError
    end 
    
    je_array.each { |j| 
  # STDERR.puts "loop date is " + date.to_s + " j.date is " + j.date.to_s
         if indate >= j.date          
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

end

