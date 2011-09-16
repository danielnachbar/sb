module AccountsHelper 
  
def load_accts(date) 
  @assets =      accounts_by_type("assets")     
  @liabilities = accounts_by_type("liabilities") 
  @income =      accounts_by_type("income")
  @expenses =    accounts_by_type("expenses")    
end

  private
     def accounts_by_type             
       retval = {};                                      
       %w{income expense asset liability}.each do |t|
         retval[t] = Account.where(:atype => t)
       end
       retval
     end
  
end
