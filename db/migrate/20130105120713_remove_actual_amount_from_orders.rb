class RemoveActualAmountFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :actual_amount
  end

  def down
    add_column :orders, :actual_amount, :float
  end
end
