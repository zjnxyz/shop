class AddActualSumtFromOrders < ActiveRecord::Migration
  def change
    add_column :orders, :actual_sum, :float
  end
end
