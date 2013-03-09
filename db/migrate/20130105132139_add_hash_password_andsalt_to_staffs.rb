class AddHashPasswordAndsaltToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :hash_password, :string
    add_column :staffs, :salt, :string
  end
end
