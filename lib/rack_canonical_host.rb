require 'rack_canonical_host/version'
require 'rack/request'
require 'uri'

module RackCanonicalHost
  # Redirect Tge rack middleware for redirecting requests to configured
  # hostname
  class Redirect
    attr_reader :canonical_host, :config
    def initialize(app, canonical_host, config = {})
      @app = app
      @canonical_host = canonical_host.downcase
      @config = config
    end

    def call(env)
      request = Rack::Request.new(env)
      return @app.call(env) if match_host(request)
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

    def match_host(request)
      return true if whitelisted(request)
      request.host.downcase == canonical_host
    end

    def whitelisted(request)
      return false unless config[:whitelist_paths]
      config[:whitelist_paths].each do |path|
        return true if path.match(request.fullpath)
      end
      false
    end
  end
end
