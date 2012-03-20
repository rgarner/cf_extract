require 'dm-migrations'

#noinspection RubyResolve
Dir[File.join(File.dirname(__FILE__), 'model/*')].each { |model| require File.expand_path(model) }

DataMapper::Logger.new($stdout, :debug)
# A MySQL connection:
DataMapper.setup(:default, 'mysql://localhost/cf-extract')

DataMapper.finalize
DataMapper.auto_upgrade!
