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

  def unit_price
    product_unit = Unit.new(product.units)
    output_unit = Unit.new(product.category.standard_units)
    price_scalar = (price.to_f / (product_unit / output_unit)).scalar

    unit_money = Money.new(price_scalar * 100, price.currency)
    "#{unit_money.format} / #{output_unit}"
  end
end
