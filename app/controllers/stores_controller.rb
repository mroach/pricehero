class StoresController < BaseResourcesController
  def show
    @prices = ProductsQuery.new(@store).product_prices
    super
  end

  protected

  def permitted_params
    %i(
      name
      alternate_name
      latitude
      longitude
      address
      locality
      state_province
      postal_code
      country
      location_description
    )
  end
end
