class AddStatusToSells < ActiveRecord::Migration
  def change
    add_column :sells, :status, :boolean
  end
end
