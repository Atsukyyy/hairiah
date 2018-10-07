class AddUserIdToUserHairStyles < ActiveRecord::Migration[5.1]
  def change
    add_column :user_hair_styles, :user_id, :integer
  end
end
