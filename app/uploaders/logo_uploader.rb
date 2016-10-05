# CarrierWave uploader for logos.
# Creates versions: thumb, small, and medium
class LogoUploader < BaseUploader
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
