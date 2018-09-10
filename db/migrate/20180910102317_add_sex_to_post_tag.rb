class AddSexToPostTag < ActiveRecord::Migration[5.1]
  def change
    add_column :post_tags, :mens, :boolean
    add_column :post_tags, :women, :boolean
  end
end
