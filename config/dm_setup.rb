# This is where local settings live (for now, at least)
# When setting up the app, copy this to 'settings.rb' and change any
# relevant details
ENV['RACK_ENV'] ||= 'development'

require 'yaml'

database_config_path = File.expand_path('database.yml', File.dirname(__FILE__))
config = YAML.load(File.open(database_config_path))[ENV['RACK_ENV']]

host = config['host'] || 'localhost'
user_string = config['password'] ? "#{config['username']}:#{config['password']}" : config['username']

DataMapper::setup(:default, "#{config['adapter']}://#{user_string}@#{host}/#{config['database']}")

DataMapper.finalize

case ENV['RACK_ENV']
  when 'test'
    DataMapper.auto_migrate!
  else
    DataMapper.auto_upgrade!
end
