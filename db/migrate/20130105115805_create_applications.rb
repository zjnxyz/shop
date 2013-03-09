class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :sell
      t.references :user
      t.references :staff
      t.integer :type
      t.text :remark
      t.boolean :is_handle

      t.timestamps
    end
    add_index :applications, :sell_id
    add_index :applications, :user_id
    add_index :applications, :staff_id
  end
end
