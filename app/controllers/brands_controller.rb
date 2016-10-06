class BrandsController < BaseResourcesController
  protected

  def permitted_params
    %i(name country logo)
  end
end
