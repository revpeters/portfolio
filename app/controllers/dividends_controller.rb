class DividendsController < ApplicationController
  after_action :process_payouts, only: [:create]

  def index
    @dividends = Dividend.all
    @data = [
      {name: "PFFA", data: {"Jan"=>0.0, "Feb"=>21.12, "Mar"=>420.96}},
      {name: "IBHD", data: {"Nov"=>127.44, "Dec"=>106.2, "Jan"=>0.0, "Feb"=>210.0, "Mar"=>189.0}}
    ]
    #DistributionPayment.distinct.pluck(:ticker)
    #dist_payments.each {|each| dist_hash[each.payment_date.strftime("%b")] = each.payment}
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

  def chart_data
    tickers = Investment.distinct.pluck(:ticker)
    tickers.each {|ticker| puts DistributionPayment.where(ticker: ticker)}
    #payouts.length.times { |ticker| payments = DistributionPayment.where(ticker: "#{payouts[ticker]}") }
    #payouts.length.times { |ticker| data_for_payments.push(payouts[ticker], DistributionPayment.where(ticker: "PFFA").each {|each| puts "#{each.payment_date.strftime("%b")} #{each.payment}"})}
    #DistributionPayment.where(ticker: "PFFA").each {|each| puts "#{each.payment_date.strftime("%b")} #{each.payment}"}
    payouts.length.times {|ticker| data_for_payments.push([payouts[ticker-1], DistributionPayment.where(ticker: "#{payouts[ticker-1]}").each {|each| array_for_data.push([each.payment_date.strftime("%b"), each.payment])}])}
  end

  private
    
    def dividend_params
      params.require(:dividend).permit(:ticker, :dividend, :date_paid)
    end


end
