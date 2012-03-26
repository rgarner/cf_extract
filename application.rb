require 'sinatra'
require 'haml'
require 'rack/conneg'

use(Rack::Conneg) { |conneg|
  conneg.set :accept_all_extensions, false
  conneg.provide([:json])
}

before do
  if negotiated?
    content_type negotiated_type
  end
end

get '/' do
  redirect '/years'
end

get '/years' do
  @years = Award.years
  respond_to do |wants|
    wants.html { haml :years }
    wants.json { @years.to_json }
  end
end

get '/years/:year' do
  @quarters = Award.for_year(params[:year].to_i).group_by {|a| a.date.quarter }
  respond_to do |wants|
    wants.html  { haml :year }
    wants.json  { @quarters.to_json }
  end
end