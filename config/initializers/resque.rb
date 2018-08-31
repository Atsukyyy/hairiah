# # Establish a connection between Resque and Redis
# require "addressable/uri"
#
# if Rails.env == "production"
#   uri = Addressable::URI.parse ENV["REDISCLOUD_URL"]
#   Resque.redis = Redis.newhost:uri.host, port:uri.port, password:uri.password
# else
#   # conf for your localhost
# end
