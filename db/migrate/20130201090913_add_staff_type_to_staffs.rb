class AddStaffTypeToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :staff_type, :integer
  end
end
