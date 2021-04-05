class CreateDistributionPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :distribution_payments do |t|
      t.string :ticker
      t.float :payment
      t.date :payment_date

      t.timestamps
    end
  end
end
