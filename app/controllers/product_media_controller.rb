class ProductMediaController < ApplicationController
  before_action :set_product_medium, only: [:show, :edit, :update, :destroy]

  # GET /product_media
  def index
    @product_media = ProductMedium.all
  end

  # GET /product_media/1
  def show
  end

  # GET /product_media/new
  def new
    @product_medium = ProductMedium.new(product_medium_params)
  end

  # GET /product_media/1/edit
  def edit
  end

  # POST /product_media
  def create
    @product_medium = ProductMedium.new(product_medium_params)

    if @product_medium.save
      redirect_to @product_medium, notice: 'Product medium was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /product_media/1
  def update
    if @product_medium.update(product_medium_params)
      redirect_to @product_medium, notice: 'Product medium was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_media/1
  def destroy
    @product_medium.destroy
    redirect_to product_media_url, notice: 'Product medium was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_medium
    @product_medium = ProductMedium.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_medium_params
    return {} unless params.key? :product_medium
    params.require(:product_medium).permit(%i(product_id file content_type size title position))
  end
end
