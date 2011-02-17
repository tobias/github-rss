require 'rubygems'
require 'sinatra'
require 'feed_parser'
require 'dalli'

CACHE = Dalli::Client.new

get '/' do
  if params[:feed] 
    FeedParser.new(params[:feed], params[:user], params[:token]).parse
  else
    "Please provide the feed url as a query parameter, like so:\n" +
      "http://app.hostname/?feed=https://github.com/your/project/feed\n\n" +
      "If you are accessing a private repo, you'll need to provide user and " +
      "token params for your github username and token,"
  end
end

