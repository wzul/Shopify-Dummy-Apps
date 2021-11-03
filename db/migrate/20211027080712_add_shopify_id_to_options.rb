class AddShopifyIdToOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :options, :shop_id, :integer
    add_index :options, :shop_id
  end
end
