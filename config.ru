require 'rubygems'
require 'sinatra'

set :port, 9393

get '/' do
	erb :index, :locals => {:nameToFind => ""}
end

post '/people' do
	# Récupère l'id pour le moment
	puts params[:id]

	erb :index, :locals => {:nameToFind => params[:nameToFind]}
end

get '/*' do
	erb :not_found
end

run Sinatra::Application