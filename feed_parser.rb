require 'json'
require 'nokogiri'
require 'open-uri'
require 'restclient'

class FeedParser
  def initialize(feed_url, user, token)
    @feed_url = feed_url
    @user = user
    @token = token
  end

  def parse
    @feed = Nokogiri::XML(open(@feed_url))
    puts @feed_url
    add_diffs
    @feed.to_xml
  end

  def add_diffs
    @feed.css("feed entry").each do |entry|
      commit_url = entry.css("link").first['href']
      if commit_url =~ %r{github.com/(.*?)/(.*?)/commit/([a-f0-9]*)$}
        user, repo, sha = $1, $2, $3
        key = "#{user}/#{repo}/#{sha}"
        commit = CACHE.get(key)
        if !commit
          commit = RestClient::Resource.new("https://github.com/api/v2/json/commits/show/#{key}",
                                          "#{@user}/token",
                                            @token).get
          CACHE.put(key, commit)
        end
        
        commit = JSON.parse(commit)["commit"]
        diff = "<pre>"
        (commit["modified"] || []).each do |mod|
          diff << "\n\n"
          diff << mod["diff"]
        end
        diff << "</pre>"
        entry.css('content').first.content += diff
      end

    end
  end
end