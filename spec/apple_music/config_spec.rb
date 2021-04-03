require 'spec_helper'
require 'apple_music/config'

RSpec.describe AppleMusic::Config do
  before :each do
    @config = described_class.new
    @secret_key = <<~TEXT
      -----BEGIN PRIVATE KEY-----
      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+-
      -abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+
      +-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
      9+-abcde
      -----END PRIVATE KEY-----
    TEXT
  end

  it 'can pick up a secret key from an environment variable' do
    expectation = 'dummy secret key from environment'
    ENV['APPLE_MUSIC_SECRET_KEY'] = expectation
    @config = described_class.new
    ENV.delete 'APPLE_MUSIC_SECRET_KEY'

    expect(@config.secret_key).to eq(expectation)
  end

  it 'ensures a secret key can continue to be specified using a path to a file' do
    expectation = @secret_key
    @config.secret_key_path = 'spec/fixtures/sample_private_key.p8'

    expect(@config.send :apple_music_secret_key).to eq(expectation)
  end

  it 'can pick up a secret key path from an environment variable' do
    expectation = @secret_key
    ENV['APPLE_MUSIC_SECRET_KEY_PATH'] = 'spec/fixtures/sample_private_key.p8'
    @config = described_class.new
    ENV.delete 'APPLE_MUSIC_SECRET_KEY_PATH'

    expect(@config.send :apple_music_secret_key).to eq(expectation)
  end

  it 'ensures a specified secret key takes precedence over a secret key file' do
    expectation = 'dummy secret key'
    @config.secret_key = expectation
    @config.secret_key_path = 'spec/fixtures/sample_private_key.p8'

    expect(@config.send :apple_music_secret_key).to eq(expectation)
  end

end
