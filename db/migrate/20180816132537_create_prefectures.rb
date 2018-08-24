class CreatePrefectures < ActiveRecord::Migration[5.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end
end
