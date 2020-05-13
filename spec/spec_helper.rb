# encoding: UTF-8
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'shoulda/matchers'
require 'pry'
require 'full_circle'
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  # c.default_cassette_options = { record: :new_episodes, match_requests_on: [:uri, :body, :headers] }
  # c.debug_logger = File.open("./spec/fixtures/vcr-logger.log", 'w')
  c.allow_http_connections_when_no_cassette = true
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
end
