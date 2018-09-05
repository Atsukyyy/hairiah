class AddPermedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hair_permed, :string
    add_column :users, :boolean, :string
  end
end
