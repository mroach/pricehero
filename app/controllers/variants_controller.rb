class VariantsController < ApplicationController
  before_action :set_variant, only: %i(show edit update destroy)

  # GET /variants
  def index
    @variants = Variant.all
  end

  # GET /variants/1
  def show
    @prices_query = PricesQuery.new(@variant)
    @best_price = @prices_query.best_price
    @prices = @prices_query.store_prices
    @report = @variant.reports.new
  end

  # GET /variants/new
  def new
    @variant = Variant.new(variant_params)
  end

  # GET /variants/1/edit
  def edit
  end

  # POST /variants
  def create
    @variant = Variant.new(variant_params)

    if @variant.save
      redirect_to @variant, notice: 'Variant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /variants/1
  def update
    if @variant.update(variant_params)
      redirect_to @variant, notice: 'Variant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /variants/1
  def destroy
    @variant.destroy
    redirect_to variants_url, notice: 'Variant was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.friendly.find params[:product_id]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_variant
    @variant = Variant.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def variant_params
    return {} unless params.key? :variant
    params.require(:variant).permit(:product_id, :piece_count, :piece_name, :units, :gtin)
  end
end
