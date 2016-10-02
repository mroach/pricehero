class ProductsController < ApplicationController
  before_action :set_product, only: %i(show edit update destroy)

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
    @prices_query = PricesQuery.new(@product)
    @best_price = @prices_query.best_price
    @prices = @prices_query.store_prices
    @report = @product.reports.new
  end

  # GET /products/new
  def new
    @product = Product.new(product_params)
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.permit(:product).permit(
      %i(
        brand_id name category_id piece_count piece_name units gtin
      )
    )
  end
end
