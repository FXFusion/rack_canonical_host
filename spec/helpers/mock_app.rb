require 'rack/request'
module RackCanonicalHost
  class MockApp
    attr_accessor :last_request

    def call(env)
      self.last_request = Rack::Request.new(env)
      [200, {}, 'ok']
    end
  end
end
