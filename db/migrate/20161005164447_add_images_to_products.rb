class AddImagesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :images, :jsonb
  end
end
