
class MyMoney < Money
end
class JesController < ApplicationController

  def index     
    @title = "Journal Entries"
    @jelist =  Je.all
  end

  def updatelist     
    @title = "Journal Entries"
    @jelist =  Je.all
  end

  def deletelist     
    @title = "Choose a Journal Entry to Delete"
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

  def edit  
    @je = Je.find(params[:id])
    @title = "Edit Journal Entry"    
  end             
  
  def update

    params[:je][:amount] =   params[:je][:amount].to_money.cents.to_s # run input thorough the Money parser 
    datestring = params[:je][:date]
    params[:je][:date]   =   Date.new(datestring[6,4].to_i,datestring[0,2].to_i,datestring[3,2].to_i)
    
    @je = Je.find(params[:id])      
    if @je.update_attributes(params[:je])  

      redirect_to je_path(@je.id), :flash => { :success => "Journal Entry Updated!" }
    else
      @title = "Edit Journal Entry"
      render :edit
    end                   
  end
 
  def destroy
    @je = Je.find(params[:id]) 
    @je.destroy   
    redirect_to deletelist_jes_path, :flash => { :success => "Journal Entry # #{params[:id]} Destroyed." }    
  end
  
end

def get_account_name_by_id(aid)    
  Account.find(aid).name
end
                    
def date_text(date)        
  str = date.to_s
  str[5,2] + "/" + str[8,2]   + "/" + str[0,4]    # swap fields around to work with datepicker
end