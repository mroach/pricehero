class ReportsController < BaseResourcesController
  def create
    build_resource
    resource.user = current_user
    super
  end

  protected

  def permitted_params
    %i(store_id variant_id reported_at price)
  end

  def after_create_path
    @report.variant
  end
end
