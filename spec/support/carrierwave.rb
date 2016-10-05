RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers, type: :uploader
end
