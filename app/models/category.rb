# Product categories
class Category < ApplicationRecord
  extend FriendlyId

  has_paper_trail
  friendly_id :name, use: :slugged

  has_many :products

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  default_scope -> { order('name') }

  def to_s
    name
  end
end
