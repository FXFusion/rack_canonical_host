$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack_canonical_host'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
