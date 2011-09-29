#require 'reports_helper'

# include ReportsHelper

class ReportsController < ApplicationController   

  def index
  end
    
  def balancesheet 
    @title = "Balance Sheet"         
    
    s = Books.current.state
    c = s[:children]     
    @assets = c["asset"]             
    @liabilities = c["liability"]             
    
    @owners_equity = @assets[:balance] + @liabilities[:balance]
    @total_liabilities = @liabilities[:balance] - @owners_equity      
  end

  def pandl 
    @title = "Income Statement"         
    
    s = Books.current.state
    c = s[:children]     
    @income = c["income"]             
    @expense = c["expense"]             
    
    @net_income = @income[:balance] + @expense[:balance]
  end

end
