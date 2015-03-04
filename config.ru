require 'rubygems'
require 'sinatra'

set :port, 8080

get '/' do
  erb :hello
end

run Sinatra::Application.run!