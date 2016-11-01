class ProductMediaController < BaseResourcesController
  protected

  def permitted_params
    %i(product_id file title position)
  end

  def after_create_path
    @product
  end
end
