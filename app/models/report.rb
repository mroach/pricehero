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
end
