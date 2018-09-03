class RemoveSomeFromUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :omniauth_sign_up
    remove_column :users, :reason
    remove_column :users, :age
    remove_column :users, :admin
  end

  def down
    add_column :users, :omniauth_sign_up, :boolean
    add_column :users, :reason, :integer
    add_column :users, :age, :integer
    add_column :users, :admin, :boolean
  end
end
