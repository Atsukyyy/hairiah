class CreateApplies < ActiveRecord::Migration[5.1]
  def change
    create_table :applies do |t|
      t.string :memo
      t.integer :micropost_id

      t.timestamps
    end
  end
end
