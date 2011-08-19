module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round", :width => "60", :height => "50")
  end  
  
end
