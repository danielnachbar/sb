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
      return int_to_money(-a.balance)
    when "liability"
      return int_to_money(-a.balance)
    end                
    int_to_money(a.balance)
  end
  
end
