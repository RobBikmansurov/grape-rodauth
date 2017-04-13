# frozen_string_literal: true

require 'spec_helper'
require 'rspec'
require 'rack/test'
require 'rspec/roda'

RSpec.describe Auth, roda: :app do
  include Rack::Test::Methods
  describe '/login' do
    before { post '/login', {"login":"test@site.com", "password":"password"}, { 'Content-Type' => 'application/json' } }

    it { is_expected.to be_successful }
    its(:body) { is_expected.to eq 'Hey!' }
  end
end
