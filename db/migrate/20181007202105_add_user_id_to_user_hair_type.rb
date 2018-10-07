class AddUserIdToUserHairType < ActiveRecord::Migration[5.1]
  def change
    add_column :user_hair_types, :user_id, :integer
  end
end
