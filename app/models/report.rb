# Instance of a variant seen at a store and its price, or stock missing
class Report < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :variant
  belongs_to :store
  belongs_to :user

  monetize :price_cents, as: :price, numericality: { greater_than: 0 }

  validates :store, presence: true
  validates :variant, presence: true
  validates :reported_at, presence: true

  default_scope -> { order('reported_at DESC') }

  after_initialize :set_defaults, unless: :persisted?

  delegate :product, to: :variant

  def unit_price
    UnitPriceCalculator.new(
      price,
      variant.piece_count * variant.units.to_unit,
      variant.category.bulk_units
    )
  end

  def piece_price
    rate = price / variant.piece_count
    piece_name = variant.piece_name || 'piece'
    "#{rate.format} / #{piece_name.singularize}"
  end

  protected

  def set_defaults
    self.reported_at = Time.now.utc
  end
end
