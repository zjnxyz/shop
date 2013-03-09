class AddTypeToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :type, :integer
  end
end
