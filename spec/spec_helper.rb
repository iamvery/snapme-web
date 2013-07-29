ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
require 'turnip/capybara'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/steps/**/*.rb"  )].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order                                      = 'random'
  config.use_transactional_fixtures                 = false

  default_db_cleaner_strategy = :transaction

  config.before(:suite) do
    DatabaseCleaner.strategy = default_db_cleaner_strategy
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

CarrierWave.configure do |config|
  config.enable_processing = false
  config.storage           = :file
end

auth_hash = {
  provider: 'github',
  uid:      '12345',
  info:     { nickname: 'batman' },
}
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(auth_hash)
