class CreateInstagramUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users do |t|
      t.string :instagram_id
      t.string :image_url
      t.string :comment
      t.string :name
      t.string :instagram_name
      t.datetime :followed
      t.datetime :unfollowed
      t.boolean :followed_back

      t.timestamps
    end
    add_index "instagram_users", ["instagram_id"], :name => "index_instagram_users_on_instagram_id_and_user_id", :unique => true
  end
end
