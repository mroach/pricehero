# Product categories
class Category < ApplicationRecord
  extend FriendlyId

  has_paper_trail
  has_closure_tree order: :name
  friendly_id :name, use: :slugged

  has_many :products

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :valid_units

  def to_s
    name
  end

  protected

  def should_generate_new_friendly_id?
    slug.nil? || (changes.keys & %w(name)).any?
  end

  def valid_units
    # Allow blank units by returning out now
    return if bulk_units.blank?

    begin
      unit = Unit.new(bulk_units)
    rescue ArgumentError
      return errors.add(:bulk_units, 'invalid')
    end
    return errors.add(:bulk_units, 'missing unit of measure') if unit.units.blank?
  end
end
