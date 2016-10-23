CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :aws
    config.aws_bucket = 'pricehero'
    config.aws_acl = 'public-read'

    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching
    config.aws_attributes = {
      expires:       1.week.from_now.httpdate,
      cache_control: "max-age=#{365.days.to_i}"
    }

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region:            'ap-southeast-1'
    }
  else
    config.storage = :file
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
end
