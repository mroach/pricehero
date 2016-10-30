# Product brands
class Brand < ApplicationRecord
  include PgSearch
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :name, use: :slugged
  multisearchable against: :name, unless: :deleted?

  has_many :products

  mount_uploader :logo, LogoUploader

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  default_scope -> { order('name') }

  def to_s
    name
  end

  protected

  def should_generate_new_friendly_id?
    name_changed?
  end
end
