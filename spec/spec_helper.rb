# encoding: UTF-8
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rspec'
require 'vcr'
require 'full_circle'
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
end

RSpec.configure do |c|
    c.extend VCR::RSpec::Macros
end
