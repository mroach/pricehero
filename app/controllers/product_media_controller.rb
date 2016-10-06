class ProductMediaController < BaseResourcesController
  protected

  def permitted_params
    %i(product_id file title position)
  end
end
