module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round", :width => "60", :height => "50")
  end  

  def int_to_money(val)     
    Money.new(val).format(:symbol => false)        
  end  
  
  def sign_corrected_balance(a)        
    case a.atype
    when "income"   
      return -a.balance
    when "liability"
      return -a.balance
    end                
    a.balance
  end
  
end
