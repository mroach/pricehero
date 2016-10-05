CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
end

RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers, type: :uploader
end
