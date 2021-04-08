class InvestmentsController < ApplicationController

  def index
    @investments = Investment.all
  end
  
  def edit
    
  end
  
  def create
    @investment = Investment.new(investment_params)
    @investment.save
    redirect_to '/investments'    
  end

  def delete

  end

  private
    
    def investment_params
      params.require(:investment).permit(:ticker, :shares_purchased, :cost_per_share, :buy_date, :sell_date)
    end               
end
