class CreateAcounts < ActiveRecord::Migration
  def change
    create_table :acounts do |t|
      t.string :hash_url
      t.integer :u_id
      t.integer :acount_type

      t.timestamps
    end
  end
end
