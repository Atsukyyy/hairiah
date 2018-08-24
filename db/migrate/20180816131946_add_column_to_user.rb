class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birth, :date
    add_column :users, :sex, :integer
    add_column :users, :color, :boolean
    add_column :users, :hair_extension, :boolean
    add_column :users, :nail, :boolean
    add_column :users, :reason, :integer
    add_column :users, :hair_type, :integer
    add_column :users, :area_id, :integer
    add_column :users, :prefecture_id, :integer
    add_column :users, :hair_style, :integer
    add_column :users, :age, :integer
    add_column :users, :staff, :boolean, default: false
    add_column :users, :last_accessed_at, :date
  end
end
