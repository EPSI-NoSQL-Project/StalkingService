require 'rubygems'
require 'sinatra'

set :port, 8080

get '/' do
	erb :index, :locals => {:nameToFind => ""}
end

post '/people' do
	
	erb :index, :locals => {:nameToFind => params[:nameToFind]}
end

get '/*' do
	erb :not_found
end

run Sinatra::Application