class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price
      t.string :status
      t.decimal :credit
      t.text :remarks
      t.text :shipping_address
      t.string :notification_phone_number
      t.string :voucher_code
      t.references :delivery_mode, null: true, foreign_key: true

      t.timestamps
    end
  end
end
