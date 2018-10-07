class CreateUserHairStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_hair_styles do |t|

      t.timestamps
    end
  end
end
