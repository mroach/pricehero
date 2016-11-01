class ProductsController < BaseResourcesController
  before_action :set_collections, only: %i(new edit)

  def show
    @prices = @product.variants.map { |v| PricesQuery.new(v) }
    super
  end

  protected

  def set_collections
    @brands = Brand.all
    @categories = Category.all.map { |cat| [cat.path, cat.id] }.sort
  end

  def permitted_params
    [
      :brand_id,
      :name,
      :category_id,
      images: []
    ]
  end
end
