# CarrierWave uploader for logos.
# Creates versions: thumb, small, and medium
class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small do
    process resize_to_fit: [100, 100]
  end

  version :medium do
    process resize_to_fit: [200, 200]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # For Brands, to_s is the name
  def filename
    "#{model.to_s.parameterize}#{File.extname(original_filename)}" if original_filename
  end
end
