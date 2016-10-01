class ReportsController < ApplicationController
  before_action :set_product, only: %i(new create)
  before_action :set_report, only: %i(show edit update destroy)

  # GET /reports
  def index
    @reports = params.has_key?(:product_id) ? set_product : Report.all
  end

  # GET /reports/1
  def show
  end

  # GET /product/:product_id/reports/new
  def new
    @report = Report.new product: @product
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /product/:product_id/reports
  def create
    @report = Report.new(report_params)
    @report.product = @product

    if @report.save
      redirect_to @product, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      redirect_to @report, notice: 'Report was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    redirect_to reports_url, notice: 'Report was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.friendly.find params[:product_id]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def report_params
    params.require(:report).permit(:store_id, :reported_at, :price)
  end
end
