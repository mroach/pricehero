class BaseResourcesController < ApplicationController
  before_action :set_resource, only: %i(show edit update destroy)

  def index
    respond_with instance_variable_set("@#{resources_name}", policy_scope(resource_class).all)
  end

  def show
    authorize resource
    respond_with resource
  end

  def new
    authorize resource_class

    # If the method was overriden and 'resource' was already setup, don't
    # overwrite it by building it from the parameters
    build_resource unless resource.present?
  end

  def create
    authorize resource_class

    # If the method was overriden and 'resource' was already setup, don't
    # overwrite it by building it from the parameters
    build_resource unless resource.present?

    if resource.save
      respond_with after_create_path, notice: 'Created'
    else
      respond_with resource do |format|
        format.html { render :new }
        format.json { respond_with_errors resource }
      end
    end
  end

  def update
    authorize resource
    if resource.update(resource_params)
      respond_with resource do |format|
        format.html { redirect_to after_update_path, notice: 'Updated' }
        format.json { render json: resource }
      end
    else
      respond_with resource do |format|
        format.html { render :edit }
        format.json { respond_with_errors resource }
      end
    end
  end

  def edit
    authorize resource
  end

  def destroy
    authorize resource
    resource.destroy
    respond_with resource do |format|
      format.html { redirect_to after_destroy_path, notice: 'Destroyed' }
      format.json { render status: :no_content }
    end
  end

  protected

  def after_destroy_path
    resource_index_locator
  end

  def after_update_path
    resource
  end

  def after_create_path
    resource
  end

  def build_resource
    instance_variable_set("@#{resource_name}", resource_class.new(resource_params))
  end

  def resource
    instance_variable_get("@#{resource_name}")
  end

  def resource_params
    # For JSON API, we need to use the JSON API deserializer. The object is sent
    # in a specific format that the default system doesn't support
    # For any other kind of request use the standard parameter fetcher
    if request.format == 'application/vnd.api+json'
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: permitted_params)
    else
      return {} unless params.key? resource_name.to_sym
      params.require(resource_name.to_sym).permit(permitted_params)
    end
  end

  # Generates an array of parts to locate the resource when generating URLs
  # For example, [:admin, :accounts] where you'd do admin_accounts_path
  def resource_index_locator
    self.class.name.sub(/Controller$/, '').split('::').map(&:underscore).map(&:to_sym)
  end

  # Used in the before_action callback to set the instance variable matching
  # the resource name and loading the resource from the database
  def set_resource
    instance_variable_set("@#{resource_name}", load_resource)
  end

  # Loads the resource from the database. If the resource uses FriendlyId,
  # we need to chain .friendly before .find
  def load_resource
    if resource_class.respond_to? :friendly_id
      resource_class.friendly.find params[:id]
    else
      resource_class.find params[:id]
    end
  end

  def resource_class
    resource_class_name.constantize
  end

  def resource_class_name
    self.class.name.sub(/Controller$/, '').singularize
  end

  def resource_name
    resources_name.singularize
  end

  def resources_name
    # SeaHorsesController => sea_horses
    # Admin::Accounts => accounts
    self.class.name.split('::').last.sub(/Controller$/, '').underscore
  end
end
