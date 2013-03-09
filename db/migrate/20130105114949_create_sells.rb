class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.integer :amount
      t.float :actual_sum
      t.float :sum
      t.text :remark
      t.references :user
      t.references :staff
      t.references :product

      t.timestamps
    end
    add_index :sells, :user_id
    add_index :sells, :staff_id
    add_index :sells, :product_id
  end
end
