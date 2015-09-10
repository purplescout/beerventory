class CreateInventory < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :organization, null: false
      t.references :beer, null: false
      t.integer :amount, null: false, default: 0
    end

    add_index :inventories, [:organization_id, :beer_id], unique: true
  end
end
