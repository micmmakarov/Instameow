class AddParentToInstagramUser < ActiveRecord::Migration
  def change
    add_column :instagram_users, :parent_instagram_id, :string
  end
end
