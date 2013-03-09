class CreateRepurchases < ActiveRecord::Migration
  def change
    create_table :repurchases do |t|
      t.integer :amount
      t.float :sum
      t.float :actual_sum
      t.text :remark
      t.references :sell
      t.references :staff
      t.references :user

      t.timestamps
    end
    add_index :repurchases, :sell_id
    add_index :repurchases, :staff_id
    add_index :repurchases, :user_id
  end
end
