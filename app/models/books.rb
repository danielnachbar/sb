
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


  def self.state(date)
    types = %w( income expense asset liability)
    r = {}                 
    # r[:name] = self.name
    # 
    # 
    # c = {}
    # types.each { |t|
    #   c[t] = {}
    #   c[t][:name] =  t 
    #   c[t][:children] = {}
    #   Account.where(:atype => t).each { |a|       
    #       c[t][:children][a.name] = a.state(date)
    #   }
    #      
    # }                   
    # 
    # r[:children]  = c
    # r[:balance] = child_balance(c)             
        
    
    return r
  end
end
