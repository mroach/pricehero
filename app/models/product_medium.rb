# One record for every image or perhaps even video attaches to products
class ProductMedium < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  mount_uploader :file, ProductImageUploader

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :file, presence: true

  before_save :update_file_attributes

  scope :images, -> { where("content_type LIKE 'image/%'") }
  scope :videos, -> { where("content_type LIKE 'video/%'") }

  protected

  def update_file_attributes
    return unless file.present? && file_changed?
    self.content_type = file.file.content_type
    self.size = file.file.size
  end
end
