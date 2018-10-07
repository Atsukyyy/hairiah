class CreateUserHairTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_hair_types do |t|
      t.boolean :straight
      t.boolean :rather_curly
      t.boolean :curly

      t.timestamps
    end
  end
end
