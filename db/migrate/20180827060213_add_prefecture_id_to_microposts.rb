class AddPrefectureIdToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :prefecture_id, :integer
  end
end
