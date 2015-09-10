class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :barcode, null: false
      t.string :name, null: false
      t.decimal :volume
    end

    add_index :beers, :barcode, unique: true
  end
end
