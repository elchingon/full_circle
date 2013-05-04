# encoding: UTF-8
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'full_circle'
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
