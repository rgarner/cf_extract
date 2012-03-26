require 'bundler'

Bundler.setup(:default)

require 'dm-migrations'
require 'dm-validations'
require 'dm-transactions'

require 'nokogiri'
require 'uri'

#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), 'model/*.rb')].each { |model| require File.expand_path(model) }
Dir[File.join(File.dirname(__FILE__), 'lib/*.rb')].each { |lib| require File.expand_path(lib) }
Dir[File.join(File.dirname(__FILE__), 'lib/cf_extract/*.rb')].each { |lib| require File.expand_path(lib) }

require File.expand_path('config/dm_setup', File.dirname(__FILE__))