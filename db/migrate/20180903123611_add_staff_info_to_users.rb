class AddStaffInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :qualification, :date
    add_column :users, :experience, :integer
  end
end
