class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.float :discount
      t.float :conversion_rate

      t.timestamps
    end
  end
end
