# Uploader for product images. Defines a number of sizes. Uses default
# filename which is a random string and the orignal file format
class ProductImageUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :small do
    process resize_to_fit: [200, 200]
  end

  version :medium do
    process resize_to_fit: [600, 600]
  end

  version :large do
    process resize_to_fit: [800, 800]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    model.token ||= SecureRandom.uuid.delete('-')
  end
end
