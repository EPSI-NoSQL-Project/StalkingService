require 'rubygems'
require 'sinatra'
require 'ashikawa-core'
require './workers/redis_worker.rb'

set :port, 9393

get '/' do
	erb :index, :locals => {:nameToFind => "", :location => ""}
end

get '/people' do
	arangodb = Ashikawa::Core::Database.new do |config|
		config.url = 'http://localhost:8529'
		config.logger = logger
	end

	peopleCollection = arangodb['people']
	thePerson = peopleCollection.fetch(params[:id])
	
	erb :person_details, :locals => {
			:id => params[:id], 
			:nameToFind => thePerson['name'], 
			:location => thePerson['location'],
			:twitterInfos => thePerson['data']['twitter_crawler'],
			:googleInfos => thePerson['data']['google_crawler'],
			:enjoygramInfos => thePerson['data']['enjoygram_crawler'],
			:youtubeInfos => thePerson['data']['youtube_crawler'],
			:activeNav => params[:activeNav]
		}
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