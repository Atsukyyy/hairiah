class AddPostIdToPostTag < ActiveRecord::Migration[5.1]
  def change
    add_column :post_tags, :micropost_id, :integer
  end
end
