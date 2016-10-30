# Represents a product. Brand and units are essential.
# e.g.) Kraft Vegemite 200g
class Product < ApplicationRecord
  include PgSearch
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :description, use: :slugged
  mount_uploaders :images, ProductImageUploader
  multisearchable against: :description, unless: :deleted?

  belongs_to :brand
  belongs_to :category
  has_many :variants, dependent: :destroy
  has_many :media, class_name: ProductMedium

  validates :brand, presence: true
  validates :name, presence: true

  default_scope -> { includes(:brand).order('brands.name, products.name') }

  def description
    [brand.try(:name), name].join(' ')
  end

  def to_s
    description
  end

  protected

  def should_generate_new_friendly_id?
    slug.nil? || (changes.keys & %w(brand_id name)).any?
  end
end
