# Use an in-memory SQLite3 database.
ENV['DATABASE'] = ':memory:'

require_relative '../config/application'

RSpec.configure do |config|
  config.color = true

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.before :suite do
    migrations = File.expand_path('../../db/migrate', __FILE__)

    Sequel::Migrator.run(DB, migrations)
  end
end
