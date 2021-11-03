class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :collection_slug
      t.timestamps
    end
  end
end
