class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :number
      t.string :name
      t.integer :phone
      t.string :email
      t.string :pinyin_initials
      t.references :member
      t.integer :integral
      t.text :remark

      t.timestamps
    end
    add_index :users, :member_id
  end
end
