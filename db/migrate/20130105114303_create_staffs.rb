class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :number
      t.string :name
      t.string :pinyin_initials
      t.integer :sex
      t.datetime :birthday
      t.string :card_id
      t.string :address
      t.integer :phone
      t.string :email
      t.datetime :start_work_time
      t.float :low_salary
      t.string :img_url
      t.float :allowance
      t.text :remark

      t.timestamps
    end
  end
end
