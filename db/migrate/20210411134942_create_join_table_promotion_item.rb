class CreateJoinTablePromotionItem < ActiveRecord::Migration[6.0]
  def change
    create_join_table :promotions, :items do |t|
      # t.index [:promotion_id, :item_id]
      # t.index [:item_id, :promotion_id]
    end
  end
end
