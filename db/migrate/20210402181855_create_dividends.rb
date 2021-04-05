class CreateDividends < ActiveRecord::Migration[6.1]
  def change
    create_table :dividends do |t|
      t.string :ticker
      t.float :dividend
      t.date :date_paid

      t.timestamps
    end
  end
end
