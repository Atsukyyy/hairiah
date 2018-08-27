class AddDetailsToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :end_date, :date
    add_column :microposts, :area_id, :integer
    add_column :microposts, :reason, :integer
    add_column :microposts, :mens, :boolean
    add_column :microposts, :color, :boolean
    add_column :microposts, :hair_extension, :boolean
  end
end
