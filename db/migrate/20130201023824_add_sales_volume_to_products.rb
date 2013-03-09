class AddSalesVolumeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sales_volume, :integer
  end
end
