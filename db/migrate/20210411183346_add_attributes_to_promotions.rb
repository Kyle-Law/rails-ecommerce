class AddAttributesToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :item_categories, :string, array: true, default: []
    add_column :promotions, :item_brands, :string, array: true, default: []
    add_column :promotions, :item_keyword, :string, array: true, default: []
    add_column :promotions, :description, :string
  end
end
