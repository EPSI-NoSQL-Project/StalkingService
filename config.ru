require 'rubygems'
require 'sinatra'
require './workers/redis_worker.rb'

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
	worker = RedisWorker.new
	worker.setJob(params[:nameToFind], params[:location])
	worker.saveJob()

	erb :index, :locals => {
		:nameToFind => params[:nameToFind], 
		:location => params[:location],
		:message => "We don't know "+params[:nameToFind]+", please try again latter."
	}
end

get '/*' do
	erb :not_found
end

run Sinatra::Application