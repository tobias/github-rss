require 'rubygems'
require 'sinatra'
require 'feed_parser'
require 'dalli'

CACHE = Dalli::Client.new

get '/' do
  if params[:feed] && params[:user] && params[:token]
    FeedParser.new(params[:feed], params[:user], params[:token]).parse
  else
    "Please provide the feed url, user, and token as query parameters, like so: " +
     "http://app.hostname/?feed=https://github.com/your/project/feed&user=your_gh_username&token=your_gh_token"
  end
end

