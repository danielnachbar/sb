class PagesController < ApplicationController
  def home
    @title = "SpiffyBooks Home"
  end

  def contact
    @title = "SpiffyBooks Contact"   
  end

  def about
    @title = "About SpiffyBooks"    
  end

end
