class CreateVariants < ActiveRecord::Migration[5.0]
  def change
    # Existing products are now called Variants!
    # We'll create products out of the existing records later
    rename_table :products, :variants

    # Reports should point at what are now called Variants
    rename_column :reports, :product_id, :variant_id

    create_table :products do |t|
      t.references :brand,    foreign_key: true
      t.references :category, foreign_key: true, null: false
      t.string     :name,     null: false
      t.string     :slug

      t.timestamps
      t.datetime :deleted_at
    end

    # Now modify Variants to belong to a Product
    add_column :variants, :product_id, :integer
    add_foreign_key :variants, :products

    add_index :products, :slug, unique: true
    add_index :products, :deleted_at
  end
end
