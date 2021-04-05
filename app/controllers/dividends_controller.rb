class DividendsController < ApplicationController
  after_action :process_payouts, only: [:create]

  def index
    @dividends = Dividend.all
  end
  
  def edit
    
  end
  
  def new
    @dividend = Dividend.new
  end

  def create
    @dividend = Dividend.new(dividend_params)
    @dividend.save
    redirect_to '/dividends'
  end

  def delete

  end

  def process_payouts
    lots = []
    payout = 0.0
    investments = Investment.where(ticker: "#{@dividend.ticker}")
    investments.each {|e| lots.push(e.shares_purchased) if (e.sell_date.nil? && @dividend.date_paid > e.buy_date) || (@dividend.date_paid.between?(e.buy_date, e.sell_date)) }
    lots.each {|e| payout += e * @dividend.dividend}
    @dist_payment = DistributionPayment.new({"ticker" => @dividend.ticker, "payment" => payout.floor(2), "payment_date" => @dividend.date_paid})
    @dist_payment.save
  end

  private
    
    def dividend_params
      params.require(:dividend).permit(:ticker, :dividend, :date_paid)
    end


end
