class AddPicToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :pic, :string
  end
end
