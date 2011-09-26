
# == Schema Information
#
# Table name: books
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

                    

class Books < ActiveRecord::Base     

  ATYPES = %w{income expense asset liability}

  def self.current  
     @@current_books
  end
          
@@current_books = Books.new();             # dummy value, only have one set of books for now        
@@current_books.name = "top"


  def state(date = Date.new(Time.now.year, Time.now.month, Time.now.day))    
    c = accounts_by_type(date)         
    {:name => @@current_books.name , 
     :obj => @@current_books,
     :children => c,
     :balance => balance_from_children(c) 
      }          

  end 
    
  private
  
  def accounts_by_type(date)             
    retval = {};                                      
    ATYPES.each do |t|
      retval[t] = get_node_for_type(t,date)
    end
    retval
  end

  def get_node_for_type(t,date)
    c = {}
    Account.where(:atype => t).each { |a|
      c[a.name] = a.state(date)
    }
              
    {:name => t ,
     :children => c,
     :balance => balance_from_children(c) 
    }           
  end
  
  def balance_from_children(c)
    sum = 0
    c.each { |k,v| sum +=  v[:balance]  }
    return sum
  end  
  
end
