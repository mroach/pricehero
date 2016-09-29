# Instance of a product seen at a store and its price, or stock missing
class Report < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :product
  belongs_to :store

  monetize :price_cents, numericality: { greater_than: 0 }

  validates :store, presence: true
  validates :product, presence: true
  validates :reported_at, presence: true

  default_scope -> { order('reported_at DESC') }
end
