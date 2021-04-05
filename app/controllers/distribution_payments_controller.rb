class DistributionPaymentsController < ApplicationController
  attr_accessor :ticker, :payment, :date

  def initialize(ticker, payment, date)
    @ticker = ticker
    @payment = payment
    @payment_date = date
  end

  private

    def distribution_payments_params
      params.require(:distibution_payments).permit(:ticker, :payment, :payment_date)
    end
end
