# This is what we came for! Finds the prices that we want for products
class PricesQuery
  def initialize(product)
    @product = product
  end

  # Uses store prices and filters down to the best price currently available
  def best_price
    store_prices.order('price_cents').first
  end

  # Uses the ranked reporting query and filter to price index 1, meaning
  # the latest report for each store. This allows us to get the most recent
  # prices for the product at each store
  def store_prices
    # Unscope to eliminate double filtering (such as paranoia and ordering)
    # Aside from being redundant, it causes a problem with table aliases
    Report
      .unscoped
      .select('*')
      .from(Arel.sql("(#{ranked_reports_query}) AS ranked_reports"))
      .where('store_price_index = 1')
      .order('price_cents')
  end

  protected

  # Uses a windowing function to query the reports. They're partitioned by
  # store, ordered by report date descending. The reversed rank gives us a
  # queryable index with 1 being the most recent
  def ranked_reports_query
    Report.where(product: @product).select(<<-SQL).to_sql
      reports.*,
      DENSE_RANK() OVER (
        PARTITION BY store_id
        ORDER BY reported_at DESC
      ) AS store_price_index
    SQL
  end
end
