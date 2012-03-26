ENV['RACK_ENV'] = 'test'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

require 'rack/test'
require 'webrat'
require_relative '../boot'
require_relative '../application'

Webrat.configure do |config|
  config.mode = :rack
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.include TestContentHelpers

  # Make tests transactional and rollbackable (NB: not a word) by default
  [:all, :each].each do |x|
    config.before(x) do
      repository(:default) do |repository|
        transaction = DataMapper::Transaction.new(repository)
        transaction.begin
        repository.adapter.push_transaction(transaction)
      end
    end

    config.after(x) do
      repository(:default).adapter.pop_transaction.rollback
    end
  end

  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.include RSpecExtensions::Set
end
