class CategoriesController < BaseResourcesController
  before_action :set_collections, only: %i(new edit)

  def show
    @prices = @category.products.map(&:variants).flatten.map { |v| PricesQuery.new(v) }
    super
  end

  protected

  def set_collections
    @categories = Category.all.map { |cat| [cat.path, cat.id] }.sort
  end

  def permitted_params
    %i(name bulk_units parent_id)
  end
end
