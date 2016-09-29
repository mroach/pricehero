# Product brands
class Brand < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :name, use: :slugged

  has_many :products

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  default_scope -> { order('name') }
end
