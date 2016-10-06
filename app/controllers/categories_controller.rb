class CategoriesController < BaseResourcesController
  def show
    @prices = @category.products.map(&:variants).flatten.map { |v| PricesQuery.new(v) }
    super
  end

  protected

  def permitted_params
    %i(name bulk_units parent_id)
  end
end
