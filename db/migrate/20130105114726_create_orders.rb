class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :amount
      t.float :sum
      t.float :actual_amount
      t.text :remark
      t.references :product
      t.references :user

      t.timestamps
    end
    add_index :orders, :product_id
    add_index :orders, :user_id
  end
end
