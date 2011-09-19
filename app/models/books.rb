
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
  

  def self.current  
     @@current_books
  end
          
@@current_books = Books.new();             # dummy value, only have one set of books for now        
@@current_books.name = "top"


  def state(date)    
    c = accounts_by_type(date)         
    {:name => @@current_books.name ,
     :children => c,
     :balance => balance_from_children(c) 
      }          

  end 
    
  private
  
  def accounts_by_type(date)             
    retval = {};                                      
    %w{income expense asset liability}.each do |t|
      retval[t] = get_node_for_type(t,date)
    end
    retval
  end

  def get_node_for_type(t,date)
    c = {}
    Account.where(:atype => t).each { |a|
      c[a.name] = a.state(date)
    }
              
    {:name => @@current_books.name ,
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
