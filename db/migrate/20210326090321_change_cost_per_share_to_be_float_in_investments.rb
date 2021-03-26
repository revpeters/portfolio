class ChangeCostPerShareToBeFloatInInvestments < ActiveRecord::Migration[6.1]
  def change
    change_column :investments, :cost_per_share, :float
  end
end
