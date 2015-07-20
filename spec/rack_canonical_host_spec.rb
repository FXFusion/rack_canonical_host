require 'spec_helper'
require 'helpers/mock_app'

module RackCanonicalHost
  describe Redirect do
    let!(:inner_app) { MockApp.new }
    let!(:app) do
       Redirect.new(inner_app, 'www.fivewalls.com')
     end

    it 'has a version number' do
      expect(RackCanonicalHost::VERSION).not_to be nil
    end

    it 'Makes request as usual if host matches' do
      get '/hello', { name: 'There' }, 'HTTP_HOST' => 'www.fivewalls.com'
      expect(last_response).to be_ok
      expect(last_request.path).to eq('/hello')
      expect(last_request.query_string).to eq('name=There')
    end

    it 'Redirects request if host does not match' do
      get '/hello', { name: 'Buddy' }, 'HTTP_HOST' => 'fivewalls.ca'
      expect(last_response.status).to eq(301)
      expect(last_response.location).to eq('http://www.fivewalls.com/hello?name=Buddy')
    end

    it 'Redirect root request' do
      get '/', {}, 'HTTP_HOST' => 'www.fivewalls.ca'
      expect(last_response.status).to eq(301)
      expect(last_response.location).to eq('http://www.fivewalls.com/')
    end
  end
end
