class RemoveSomeFromMicroposts < ActiveRecord::Migration[5.1]
  def up
    remove_column :microposts, :reason
    remove_column :microposts, :mens
  end

  def down
    add_column :microposts, :reason, :integer
    add_column :microposts, :mens, :boolean
  end
end
