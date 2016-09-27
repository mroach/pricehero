RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation

    # The linter is slow. Don't run it unless specifically requested
    FactoryGirl.lint if ENV['FACTORY_GIRL_LINT'] == 'true'
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
  end

  config.after(:each) do
    # Rollback transactions
    DatabaseCleaner.clean
  end
end
