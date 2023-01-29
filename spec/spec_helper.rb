require "bundler/setup"
require "forecasting"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end