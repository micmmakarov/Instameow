class AddErrorToInstagramUsers < ActiveRecord::Migration
  def change
    add_column :instagram_users, :error, :string
    add_column :instagram_users, :batch_id, :integer
  end
end
