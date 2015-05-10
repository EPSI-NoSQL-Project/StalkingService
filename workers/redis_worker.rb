require 'redis'
require 'json'

class RedisWorker
	def initialize
		self.clear
		@redis = Redis.new(:host => 'localhost', :port => 6379)
	end

	def clear
		@name = ""
		@location = ""
	end

	def setJob(name, location)
		@name = name
		@location = location
	end

	def name
		@name
	end

	def location
		@location
	end

	def toJson
		{name: @name, location: @location}.to_json
	end

	def saveJob
		@redis.rpush("workers", self.toJson)
		puts "Add : #{@name} from #{@location}"
	end
end