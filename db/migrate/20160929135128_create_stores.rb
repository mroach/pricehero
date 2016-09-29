class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :alternate_name
      t.float  :latitude
      t.float  :longitude
      t.string :address
      t.string :locality
      t.string :state_province
      t.string :postal_code
      t.string :country
      t.string :location_description
      t.string :slug

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :stores, :name
    add_index :stores, :slug, unique: true
    add_index :stores, :deleted_at
  end
end
