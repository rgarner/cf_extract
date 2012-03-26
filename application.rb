require 'sinatra'
require 'haml'

get '/' do
  redirect '/years'
end

get '/years' do
  @years = Award.years
  haml :years
end

get '/years/:year' do
  @quarters = Award.for_year(params[:year].to_i).group_by {|a| a.date.quarter }
  haml :year
end