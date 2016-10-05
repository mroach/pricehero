# Product categories
class Category < ApplicationRecord
  extend FriendlyId

  has_paper_trail
  has_closure_tree order: :name
  friendly_id :name, use: :slugged

  has_many :products

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name
  end

  protected

  def should_generate_new_friendly_id?
    slug.nil? || (changes.keys & %w(name)).any?
  end
end
