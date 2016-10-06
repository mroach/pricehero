class ProductsController < BaseResourcesController
  def show
    @prices = @product.variants.map { |v| PricesQuery.new(v) }
    super
  end

  protected

  def permitted_params
    [
      :brand_id,
      :name,
      :category_id,
      images: []
    ]
  end
end
