require 'spec_helper'
require 'apple_music/connection'
require 'faraday'
require 'faraday_middleware'

RSpec.describe AppleMusic do
  subject { described_class }
  before do
    expect(subject).to receive(:config).and_return(
      double(:config,
              authentication_token: 'token',
              adapter: Faraday.default_adapter)
            ).at_least(:once)
  end

  it 'returns a different client when the token is expired' do
    allow(subject).to receive(:auth_header_expired?).and_return(false)
    client = AppleMusic.send(:client)
    allow(subject).to receive(:auth_header_expired?).and_return(true)
    client_new = AppleMusic.send(:client)
    expect(client_new).not_to eq client
  end
end
