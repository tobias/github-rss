require 'rubygems'
require 'sinatra'
require 'feed_parser'
require 'haml'

if ENV['RACK_ENV'] == 'production'
  require 'dalli'
  CACHE =  Dalli::Client.new
else
  require 'mock_memcache'
  CACHE = MockMemcache.new
end

get '/' do
  if params[:feed] 
    FeedParser.new(params[:feed]).parse
  else
    haml :index
  end
end

