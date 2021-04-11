class CreateDeliveryModes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_modes do |t|
      t.string :name

      t.timestamps
    end
  end
end
