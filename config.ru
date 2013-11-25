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
require 'bundler/setup'

$LOAD_PATH.unshift(".")

require 'github-rss'

run Sinatra::Application
