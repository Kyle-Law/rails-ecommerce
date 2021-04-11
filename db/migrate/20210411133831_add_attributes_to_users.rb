class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :show_price, :boolean
    add_column :users, :credit, :decimal
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_reference :users, :role, null: false, foreign_key: true
  end
end
