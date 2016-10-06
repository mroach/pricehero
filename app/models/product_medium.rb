class ProductMedium < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  mount_uploader :file, ProductImageUploader

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :file, presence: true

  before_save :update_file_attributes

  protected

  def update_file_attributes
    return unless file.present? && file_changed?
    self.content_type = file.file.content_type
    self.size = file.file.size
  end
end
