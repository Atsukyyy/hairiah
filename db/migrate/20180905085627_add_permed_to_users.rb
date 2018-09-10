class AddPermedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hair_permed, :boolean
  end
end
