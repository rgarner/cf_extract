# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), "spec/support/**/*.rb")].each {|f| require f}

require_relative '../boot.rb'

RSpec.configure do |config|
  config.mock_with :rspec
end
