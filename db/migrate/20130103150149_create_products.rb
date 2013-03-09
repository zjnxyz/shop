class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :number
      t.float :purchase_price
      t.float :sell_price
      t.integer :stock_quantity
      t.boolean :status
      t.boolean :is_percentage
      t.float :percentage_price
      t.float :over_royalty_percentage
      t.boolean :is_rural_areas
      t.float :subsidies_proportion
      t.string :pinyin_initials
      t.integer :stock_lower_limit
      t.string :img_url
      t.text :summary
      t.references :unit
      t.references :category
      t.references :brand

      t.timestamps
    end
    add_index :products, :unit_id
    add_index :products, :category_id
    add_index :products, :brand_id
  end
end
