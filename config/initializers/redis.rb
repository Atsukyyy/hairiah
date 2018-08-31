# ENV['REDIS_URL'] = ENV["REDISCLOUD_URL"] if ENV["REDISCLOUD_URL"]
require "addressable/uri"

if ENV["REDISCLOUD_URL"]
  uri = Addressable::URI.parse(ENV["REDISCLOUD_URL"].encode)
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
