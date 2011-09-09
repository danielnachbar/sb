
class MyMoney < Money
end
class JesController < ApplicationController

  def index     
    @title = "Journal Entries"
    @jelist =  Je.all
  end

  def show            
    @je = Je.find(params[:id])
    @title = "New Journal Entry"          
  end

  def new            
    @je = Je.new
    @title = "New Journal Entry"
  end

  def create     
    params[:je][:amount] =   params[:je][:amount].to_money.cents.to_s # run input thorough the Money parser 
    datestring = params[:je][:date]
    params[:je][:date]   =   Date.new(datestring[6,4].to_i,datestring[0,2].to_i,datestring[3,2].to_i)
    

#STDERR.puts "params[:je][:date] is: "      +     params[:je][:date].to_s

    @je = Je.new(params[:je])

    if (@je.save)                            
      redirect_to je_path(@je.id), :flash => { :success => "Journal Entry Created!" }
    else         
      @title = "New Journal Entry"
      render :new  
    end      
  end


end
