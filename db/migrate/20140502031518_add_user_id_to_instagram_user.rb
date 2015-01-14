class AddUserIdToInstagramUser < ActiveRecord::Migration
  def change
    add_column :instagram_users, :user_id, :integer
  end
end
