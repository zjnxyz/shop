class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :img_url
      t.references :product

      t.timestamps
    end
    add_index :images, :product_id
  end
end
