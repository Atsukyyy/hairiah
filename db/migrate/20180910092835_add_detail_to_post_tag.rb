class AddDetailToPostTag < ActiveRecord::Migration[5.1]
  def change
    add_column :post_tags, :very_short, :boolean
    add_column :post_tags, :short, :boolean
    add_column :post_tags, :medium, :boolean
    add_column :post_tags, :semi_long, :boolean
    add_column :post_tags, :long, :boolean
    add_column :post_tags, :straight, :boolean
    add_column :post_tags, :rather_curly, :boolean
    add_column :post_tags, :curly, :boolean
  end
end
