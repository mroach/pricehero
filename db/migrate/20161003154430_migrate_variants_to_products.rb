class MigrateVariantsToProducts < ActiveRecord::Migration[5.0]
  def change
    Variant.all.each do |var|
      product = Product.find_or_create_by!(
        category: var.category, brand: var.brand, name: var.name
      )
      var.product = product
      var.save!
    end

    remove_column :variants, :brand_id
    remove_column :variants, :category_id
    remove_column :variants, :gtin
    remove_column :variants, :name

    change_column :variants, :product_id, :integer, null: false
  end
end
