class AddIsPromoToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :is_promo, :boolean
  end
end
