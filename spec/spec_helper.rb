require 'kairos'
require 'rspec'
require 'vcr'

# Configure rspec options
RSpec.configure do |config|
  #config.mock_framework = :mocha
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "spec/vcr"
  c.allow_http_connections_when_no_cassette = false
end