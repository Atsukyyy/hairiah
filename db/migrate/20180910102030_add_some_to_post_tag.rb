class AddSomeToPostTag < ActiveRecord::Migration[5.1]
  def change
    add_column :post_tags, :sex, :integer
    add_column :post_tags, :color, :boolean
    add_column :post_tags, :cut, :boolean
    add_column :post_tags, :hair_extension, :boolean
    add_column :post_tags, :nail, :boolean
    add_column :post_tags, :shampoo, :boolean
    add_column :post_tags, :transport_cost, :boolean
  end
end
