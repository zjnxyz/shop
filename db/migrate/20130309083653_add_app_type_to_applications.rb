class AddAppTypeToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :app_type, :integer
  end
end
