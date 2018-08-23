class AddUserRefToThumbnail < ActiveRecord::Migration[5.1]
  def change
    add_column :thumbnails, :user_id, :integer
    add_column :thumbnails, :image, :string
  end
end
