class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.uuid :uuid, null: false, default: "gen_random_uuid()"
      t.string :name, null: false
      t.string :github_url, null: false

      t.string :github_username, null: false
      t.integer :github_followers_number, null: false
      t.integer :github_following_number, null: false
      t.integer :github_starts_number, null: false
      t.integer :github_last_year_contributions_number, null: false
      t.string :github_profile_image_url, null: false

      t.string :github_organization, null: false
      t.string :github_location, null: false

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
