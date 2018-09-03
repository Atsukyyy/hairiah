class AddSomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fb_sign_up, :boolean
    add_column :users, :g_sign_up, :boolean
    add_column :users, :use, :boolean
    add_column :users, :qualification, :date
    add_column :users, :experience, :integer
  end
end
