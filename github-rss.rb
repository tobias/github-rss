# Copyright 2011 Tobias Crawley
#
# This file is part of github-rss.
#
# github-rss is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# github-rss is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with github-rss.  If not, see <http://www.gnu.org/licenses/>.
  
require 'rubygems'
require 'sinatra'
require 'feed_parser'
require 'haml'

if ENV['TORQUEBOX_APP_NAME']
  require 'torquebox-cache'
  TorqueBox::Infinispan::Cache.send(:alias_method, :set, :put)
  CACHE = TorqueBox::Infinispan::Cache.new
  # this is gross
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
elsif ENV['RACK_ENV'] == 'production'
  require 'dalli'
  require 'memcachier'
  CACHE =  Dalli::Client.new
else
  require 'mock_memcache'
  CACHE = MockMemcache.new
end

set :show_exceptions, true

get '/' do
  if params[:feed]
    content_type 'application/xml'
    FeedParser.new(params[:feed]).parse
  else
    haml :index
  end
end

