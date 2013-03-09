class AddImgurlToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :imgurl, :string
  end
end
