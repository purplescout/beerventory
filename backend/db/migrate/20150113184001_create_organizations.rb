class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :organizations, :code, unique: true
  end
end
