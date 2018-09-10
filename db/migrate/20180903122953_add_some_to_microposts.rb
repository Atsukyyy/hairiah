class AddSomeToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :title, :text
    add_column :microposts, :sex, :integer
    add_column :microposts, :start_datetime, :datetime
    add_column :microposts, :free_cut, :boolean
    add_column :microposts, :transport_cost, :boolean
    add_column :microposts, :shampoo, :boolean
    add_column :microposts, :hair_style, :integer
    add_column :microposts, :hair_type, :integer
    add_column :microposts, :use, :boolean
  end
end
