class JesController < ApplicationController
  def new            
    @je = Je.new
    @title = "New Journal Entry"
  end

  def create
    @je = Je.new(params[:je])

    if (@je.save)                            
      redirect_to je_path(@je.id), :flash => { :success => "Journal Entry Created!" }
    else         
      @title = "New Journal Entry"
      render :new  
    end      
  end


end
