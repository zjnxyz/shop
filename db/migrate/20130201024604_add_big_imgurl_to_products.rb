class AddBigImgurlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :big_imgurl, :string
  end
end
