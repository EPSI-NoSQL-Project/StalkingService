require 'rubygems'
require 'sinatra'

set :port, 9393

get '/' do
	erb :index, :locals => {:nameToFind => "", :location => ""}
end

post '/person' do
	# Récupère l'id pour arangodDB
	puts params[:id]

	erb :index, :locals => {:nameToFind => params[:nameToFind], :location => ""}
end

post '/people' do
	# nom et locatisation pour redis
	puts params[:nameToFind]
	puts params[:location]

	erb :index, :locals => {:nameToFind => params[:nameToFind], :location => params[:location]}
end

get '/*' do
	erb :not_found
end

run Sinatra::Application