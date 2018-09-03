class AddNailToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :nail, :boolean
  end
end
