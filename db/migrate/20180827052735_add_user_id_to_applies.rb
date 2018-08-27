class AddUserIdToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :user_id, :integer
  end
end
