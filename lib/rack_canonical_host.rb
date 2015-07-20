require 'rack_canonical_host/version'
require 'rack/request'
require 'uri'

module RackCanonicalHost
  # Redirect Tge rack middleware for redirecting requests to configured
  # hostname
  class Redirect
    attr_reader :canonical_host
    def initialize(app, canonical_host)
      @app = app
      @canonical_host = canonical_host.downcase
    end

    def call(env)
      request = Rack::Request.new(env)
      requested_host = request.host.downcase
      return @app.call(env) if requested_host == canonical_host
      headers = {
        'Content-Type' => 'text/html',
        'Content-Length' => '0'
      }
      headers['Location'] = build_location(request)
      [301, headers, []]
    end

    private

    def build_location(request)
      location = "#{request.scheme}://#{canonical_host}"
      location = "#{location}#{request.path}" unless request.path.empty?
      unless request.query_string.empty?
        location = "#{location}?#{request.query_string}"
      end
      location
    end
  end
end
