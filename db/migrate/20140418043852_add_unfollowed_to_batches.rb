class AddUnfollowedToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :unfollowed, :datetime
    add_column :batches, :unfollowed_not_followers, :datetime
  end
end
