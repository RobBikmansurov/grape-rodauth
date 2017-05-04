# frozen_string_literal: true

require 'grape'
require './auth'
require './api'
require 'rspec'
require 'rack/test'

describe 'API unauthorized users' do
  include Rack::Test::Methods

  let!(:rodauth) { Class.new Auth }

  let(:app) {
    Rack::Builder.new do
      eval File.read(('./config.ru'))
    end
  }

  context 'GET /api/hello' do
    it 'returns json "world for all!"' do
      get '/api/hello'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq("hello" => "world for all!")
    end
  end
  context 'GET /api/private/hello' do
    it 'returns "401 Unauthorized"' do
      get '/api/private/hello'
      expect(last_response.status).to eq(401)
      expect(JSON.parse(last_response.body)).to eq({"error" => "401 Unauthorized"})
    end
  end
  context 'GET /' do
    it 'returns "404 Not found"' do
      get '/'
      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq('404 Not Found')
    end
  end
end
