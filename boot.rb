require 'bundler'

Bundler.setup(:default)

require 'dm-migrations'
require 'dm-validations'
require 'dm-transactions'
require 'dm-serializer/to_json'

require 'nokogiri'
require 'uri'
require 'json'

#noinspection RubyResolve
def require_pattern(pattern)
  Dir[File.join(File.dirname(__FILE__), pattern)].each { |model| require File.expand_path(model) }
end

require_pattern 'model/*.rb'
require_pattern 'helpers/*.rb'
require_pattern 'lib/*.rb'
require_pattern 'lib/cf_extract/*.rb'

require File.expand_path('config/dm_setup', File.dirname(__FILE__))