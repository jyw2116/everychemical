#!/usr/bin/env ruby
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['EVERYCHEMICAL_CONSUMER_KEY']
  config.consumer_secret = ENV['EVERYCHEMICAL_CONSUMER_SECRET']
  config.access_token = ENV['EVERYCHEMICAL_ACCESS_TOKEN']
  config.access_token_secret = ENV['EVERYCHEMICAL_ACCESS_TOKEN_SECRET']
end

File.open('chemicals.txt', 'r+:UTF-8') do |file|
  # read file in as an array
  array = file.read.split("\n")

  # tweet next chemical and remove it from array
  chemical = array.shift

  # tweet the name of the chemical
  client.update(chemical)

  # erase file
  file.seek 0, IO::SEEK_SET
  file.truncate 0

  # write array back to file
  file.write array.join("\n")
end
