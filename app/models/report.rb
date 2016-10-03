# Instance of a variant seen at a store and its price, or stock missing
class Report < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :variant
  belongs_to :store

  monetize :price_cents, as: :price, numericality: { greater_than: 0 }

  validates :store, presence: true
  validates :variant, presence: true
  validates :reported_at, presence: true

  default_scope -> { order('reported_at DESC') }

  after_initialize :set_defaults, unless: :persisted?

  def unit_price
    calc = UnitPriceCalculator.new(
      price,
      variant.piece_count * variant.units.to_unit,
      variant.category.bulk_units
    )
    "#{calc.unit_price.format} / #{calc.unit_label}"
  end

  def piece_price
    rate = price / variant.piece_count
    "#{rate.format} / #{variant.piece_name.singularize}"
  end

  protected

  def set_defaults
    self.reported_at = Time.now.utc
  end
end
