class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :street
      t.string :status
      t.integer :price
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :sq_ft
      t.float :lat
      t.float :lng
      t.timestamps null: false
    end
  end
  #
  # add_index :listings, :street
  # add_index :listings, :status
  # add_index :listings, :price
  # add_index :listings, :bedrooms
  # add_index :listings, :bathrooms
  # add_index :listings, :sq_ft
  # add_index :listings, [:lat, :lng]
end
