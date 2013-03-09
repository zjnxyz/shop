class AddStatusToRepurchases < ActiveRecord::Migration
  def change
    add_column :repurchases, :status, :boolean
  end
end
