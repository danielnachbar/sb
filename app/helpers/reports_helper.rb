module ReportsHelper         
  def to_money(val)     
    Money.new(val).format(:symbol => false)        
  end  
  
end
