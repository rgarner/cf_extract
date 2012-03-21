# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

require_relative '../boot.rb'

RSpec.configure do |config|
  config.include TestContentHelpers

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

  config.include(RSpecExtensions::Set)
end
