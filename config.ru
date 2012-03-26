$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'application'

run Sinatra::Application