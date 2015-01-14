class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :app_id
      t.string :app_secret
      t.string :name

      t.timestamps
    end
  end
end
