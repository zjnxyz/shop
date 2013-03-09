class AddRealDiscountToSells < ActiveRecord::Migration
  def change
    add_column :sells, :real_discount, :float
  end
end
