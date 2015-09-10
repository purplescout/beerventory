class AddApiTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :api_token, :string
    change_column :users, :api_token, :string, null: false
    add_index :users, :api_token, unique: true
  end

  def down
    drop_index :users, :api_token
    remove_column :users, :api_token
  end
end
