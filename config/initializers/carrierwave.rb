CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog

    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region:                'ap-southeast-1'
    }
    config.fog_directory  = 'pricehero'
    config.fog_public     = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.days.to_i}" }
  else
    config.storage = :file
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
end
