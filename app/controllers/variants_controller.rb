class VariantsController < BaseResourcesController
  def show
    authorize @variant
    @prices_query = PricesQuery.new(@variant)
    @best_price = @prices_query.best_price
    @prices = @prices_query.store_prices
    @report = @variant.reports.new
  end

  protected

  def permitted_params
    %i(product_id piece_count piece_name units gtin)
  end
end
