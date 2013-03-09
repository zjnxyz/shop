class AddEndTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :end_time, :datetime
  end
end
