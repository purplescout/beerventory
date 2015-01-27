class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :organization
      t.string :role

      t.timestamps
    end

    add_index :memberships, [:user_id, :organization_id], unique: true
  end
end
