class AddBodyHtmlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :body_html, :text
  end
end
