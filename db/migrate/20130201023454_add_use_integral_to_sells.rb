class AddUseIntegralToSells < ActiveRecord::Migration
  def change
    add_column :sells, :use_integral, :integer
  end
end
