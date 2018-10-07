class AddColumnToUserHairStyles < ActiveRecord::Migration[5.1]
  def change
    add_column :user_hair_styles, :very_short, :boolean
    add_column :user_hair_styles, :short, :boolean
    add_column :user_hair_styles, :medium, :boolean
    add_column :user_hair_styles, :semi_long, :boolean
    add_column :user_hair_styles, :long, :boolean
  end
end
