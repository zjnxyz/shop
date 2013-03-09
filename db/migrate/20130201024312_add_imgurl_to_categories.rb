class AddImgurlToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :imgurl, :string
  end
end
