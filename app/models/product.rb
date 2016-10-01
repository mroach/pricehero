# Represents a product. Brand and units are essential.
# e.g.) Kraft Vegemite 200g
class Product < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :combined_name, use: :slugged

  belongs_to :brand
  belongs_to :category
  has_many :reports, dependent: :destroy

  validates :brand, presence: true
  validates :name, presence: true
  validates :piece_count, presence: true, numericality: { greater_than: 0 }
  validate :valid_gtin

  default_scope -> { includes(:brand).order('brands.name, products.name') }

  def combined_name
    parts = [brand.try(:name), name]
    parts << "#{piece_count}x" if piece_count > 1
    parts << units unless units.to_unit == Unit.new('1 piece')
    parts << piece_name.pluralize if piece_count > 1 && !piece_name.blank?
    parts.join(' ')
  end

  def to_s
    combined_name
  end

  protected

  def valid_gtin
    return if gtin.blank?
    errors.add(:gtin, 'bad checksum') unless gtin.valid_checksum?
  end

  def should_generate_new_friendly_id?
    slug.nil? || (changes.keys & %w(brand_id name units piece_count piece_name)).any?
  end
end
