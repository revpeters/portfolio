class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.string :ticker
      t.decimal :cost_per_share
      t.date :buy_date
      t.date :sell_date

      t.timestamps
    end
  end
end
