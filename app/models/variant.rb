# Represents a specific version of a product. For example a product may be
# Leo Lager, but the specific variant, the thing you actually purchase, is a
# 680 mL bottle of Leo Lager, or a 24 pack of 330 mL cans of Leo Lager
class Variant < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :description, use: :slugged

  belongs_to :product
  has_many :reports, dependent: :destroy

  validates :piece_count, presence: true, numericality: { greater_than: 0 }
  validates :product, presence: true
  validate :valid_gtin
  validate :valid_units

  delegate :brand, to: :product
  delegate :name, to: :product
  delegate :category, to: :product

  def description
    product.present? ? VariantDescription.new(self).description : nil
  end

  def to_s
    description
  end

  protected

  def valid_gtin
    return if gtin.blank?
    errors.add(:gtin, 'bad checksum') unless gtin.valid_checksum?
  end

  def valid_units
    begin
      unit = Unit.new(units)
    rescue ArgumentError
      return errors.add(:units, 'invalid')
    end
    return errors.add(:units, 'missing unit of measure') if unit.units.blank?

    if product.present? && category.try(:bulk_units).present?
      bulk_units = category.bulk_units.to_unit
      unless unit.compatible?(bulk_units)
        errors.add(:units, "incompatible with '#{bulk_units.units}'")
      end
    end
  end

  def should_generate_new_friendly_id?
    slug.nil? || (changes.keys & %w(piece_count piece_name units product_id)).any?
  end
end
