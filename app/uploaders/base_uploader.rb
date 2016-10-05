# Default setup for file uploading
class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
