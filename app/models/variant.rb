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
