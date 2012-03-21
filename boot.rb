Bundler.setup(:default)

require 'dm-migrations'
require 'dm-validations'
require 'dm-transactions'

require 'nokogiri'

#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), 'model/*.rb')].each { |model| require File.expand_path(model) }
Dir[File.join(File.dirname(__FILE__), 'lib/cf_extract/*')].each { |lib| require File.expand_path(lib) }

DataMapper::Logger.new($stdout, :debug)
# A MySQL connection:
DataMapper.setup(:default, 'mysql://localhost/cf-extract')

DataMapper.finalize
DataMapper.auto_upgrade!
