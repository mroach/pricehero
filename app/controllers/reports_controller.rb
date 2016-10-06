class ReportsController < BaseResourcesController
  protected

  def permitted_params
    %i(store_id variant_id reported_at price)
  end
end
