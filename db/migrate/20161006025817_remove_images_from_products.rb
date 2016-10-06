class RemoveImagesFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :images
  end
end
