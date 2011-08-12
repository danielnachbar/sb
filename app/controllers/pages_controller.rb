class PagesController < ApplicationController
  def home
    @title = "Spiffy Books Home"
  end

  def contact
    @title = "Contact"   
  end

  def about
    @title = "About"    
  end

end
