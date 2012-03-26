require 'yaml'

ENV['RACK_ENV'] ||= 'development'

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
