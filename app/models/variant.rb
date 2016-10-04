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
  validate :valid_gtin

  delegate :brand, to: :product
  delegate :name, to: :product
  delegate :category, to: :product

  def description
    VariantDescription.new(self).description
  end

  def to_s
    description
  end

  protected

  def valid_gtin
    return if gtin.blank?
    errors.add(:gtin, 'bad checksum') unless gtin.valid_checksum?
  end
end
