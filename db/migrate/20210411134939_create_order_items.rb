class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :unit_discount
      t.decimal :sub_total

      t.timestamps
    end
  end
end
