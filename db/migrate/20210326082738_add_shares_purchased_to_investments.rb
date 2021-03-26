class AddSharesPurchasedToInvestments < ActiveRecord::Migration[6.1]
  def change
    add_column :investments, :shares_purchased, :integer
  end
end
