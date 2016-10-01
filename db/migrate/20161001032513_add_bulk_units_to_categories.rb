class AddBulkUnitsToCategories < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :standard_units, :bulk_units
  end
end
