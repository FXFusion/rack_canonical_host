require 'rack/request'
module RackCanonicalHost
  # Mock Rack application for testing
  class MockApp
    attr_accessor :last_request

    def call(env)
      self.last_request = Rack::Request.new(env)
      [200, {}, 'ok']
    end
  end
end
