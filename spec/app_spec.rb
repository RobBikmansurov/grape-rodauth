# frozen_string_literal: true

require 'grape'
require './auth'
require './app'
require 'rspec'
require 'rack/test'

describe 'API unauthorized users' do
  include Rack::Test::Methods

  def app
    ::API
  end

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
      expect(last_response.body).to eq('401 Unauthorized')
    end
  end
end
