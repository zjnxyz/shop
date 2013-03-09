class AddHashPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hash_password, :string
    add_column :users, :salt, :string
  end
end
