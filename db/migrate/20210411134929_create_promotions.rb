class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :message
      t.integer :min
      t.boolean :mixable
      t.decimal :discount_fixed
      t.decimal :discount_percent
      t.string :gift
      t.integer :gift_quantity
      t.date :date_start
      t.date :date_end
      t.string :voucher_code

      t.timestamps
    end
  end
end
