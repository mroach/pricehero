# Finds products in a store and the best price for each one
class ProductsQuery
  attr_reader :store

  def initialize(store)
    @store = store
  end

  def product_prices
    # Unscope to eliminate double filtering (such as paranoia and ordering)
    # Aside from being redundant, it causes a problem with table aliases
    Report
      .unscoped
      .select('*')
      .from(Arel.sql("(#{ranked_reports_query}) AS ranked_reports"))
      .where('product_price_index = 1')
      .order('reported_at DESC')
  end

  protected

  # Creates a windowing function from reports, joined over to products,
  # so we can partition by product rather than variant. This allows us
  # to return a list of each product known in a store and the latest price
  def ranked_reports_query
    Report.joins(:variant).where(store: @store).select(<<-SQL).to_sql
      reports.*,
      DENSE_RANK() OVER (
        PARTITION BY product_id
        ORDER BY reported_at DESC
      ) AS product_price_index
    SQL
  end
end
