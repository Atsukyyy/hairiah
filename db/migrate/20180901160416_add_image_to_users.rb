class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string
  end

  def up
    remove_column :users, :admin
  end
end