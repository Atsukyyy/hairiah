class CreateSocialProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :social_profiles do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :email

      t.timestamps
    end
  end
end
