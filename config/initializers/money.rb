MoneyRails.configure do |config|
  config.default_currency = :thb

  # config.default_bank = EuCentralBank.new

  # To handle the inclusion of validations for monetized fields
  # The default value is true
  config.include_validations = true

  # Set default money format globally.
  config.default_format = {
    no_cents_if_whole: true
  }

  # Set default raise_error_on_money_parsing option
  # It will be raise error if assigned different currency
  # The default value is false
  #
  # Example:
  # config.raise_error_on_money_parsing = false
end
