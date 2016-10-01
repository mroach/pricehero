class PricesQuery
  def initialize(product)
    @product = product
  end

  def best_price
    store_prices.order('price_cents').first
  end

  def store_prices
    # Unscope to eliminate double filtering (such as paranoia and ordering)
    # Aside from being redundant, it causes a problem with table aliases
    Report
      .unscoped
      .select('*')
      .from(Arel.sql("(#{ranked_reports_query}) AS ranked_reports"))
      .where('store_price_index = 1')
  end

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
