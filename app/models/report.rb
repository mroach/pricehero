# Instance of a product seen at a store and its price, or stock missing
class Report < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :product
  belongs_to :store

  monetize :price_cents, as: :price, numericality: { greater_than: 0 }

  validates :store, presence: true
  validates :product, presence: true
  validates :reported_at, presence: true

  default_scope -> { order('reported_at DESC') }

  scope :latest_by_store, -> { from_latest_by_store }

  after_initialize :set_defaults, unless: :persisted?

  class << self
    protected

    def from_latest_by_store
      from(<<-SQL.strip_heredoc).where(row_number: 1)
        (SELECT *, ROW_NUMBER() OVER (
          PARTITION BY product_id, store_id ORDER BY reported_at DESC
          ) FROM reports) AS reports
      SQL
    end
  end

  def unit_price
    calc = UnitPriceCalculator.new(
      price,
      product.piece_count * product.units.to_unit,
      product.category.bulk_units
    )
    "#{calc.unit_price.format} / #{calc.unit_label}"
  end

  def piece_price
    rate = price / product.piece_count
    "#{rate.format} / #{product.piece_name.singularize}"
  end

  protected

  def set_defaults
    self.reported_at = Time.now.utc
  end
end
