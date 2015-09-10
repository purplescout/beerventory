class CreateHistory < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :user, null: false
      t.references :organization, null: false
      t.references :beer, null: false
      t.integer :in, null: false, default: 0
      t.integer :out, null: false, default: 0
    end

    add_index :histories, [:user_id, :organization_id, :beer_id], unique: true
  end
end
