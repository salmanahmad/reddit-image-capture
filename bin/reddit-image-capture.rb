#!/usr/bin/env ruby

require 'json'
require "httparty"
require 'pp'


subreddit = ARGV[0]
url = "http://www.reddit.com/r/#{subreddit}/new.json"

after = nil
query = { sort: "new" }
count = 0

while true do
  query[:after] = after if after
  content = HTTParty.get(url, :query => query)
  
  children = content["data"]["children"]
  count += children.size
  
  for child in children do
    puts child["data"]["url"]
  end
    
  after = content["data"]["after"]
  break unless after
  sleep 2
end

puts
puts "Total Count: #{count}"