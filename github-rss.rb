require 'rubygems'
require 'sinatra'
require 'feed_parser'

if ENV['RACK_ENV'] == 'production'
  require 'dalli'
  CACHE =  Dalli::Client.new
else
  require 'mock_memcache'
  CACHE = MockMemcache.new
end

get '/' do
  puts ENV.inspect
  if params[:feed] 
    FeedParser.new(params[:feed]).parse
  else
    haml :index
  end
end

