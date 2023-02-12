# frozen_string_literal: true

require 'faraday'
require 'jwt'
require 'openssl'

module AppleMusic
  class Config
    ALGORITHM = 'ES256'
    TOKEN_EXPIRATION_TIME = 60 * 60 * 24 # 1.day
    DEFAULT_STOREFRONT = 'us'

    attr_accessor :secret_key, :secret_key_path, :team_id, :music_id,
                  :token_expiration_time, :storefront, :rate_limiter, :cache_store

    def initialize
      @secret_key_path = ENV.fetch('APPLE_MUSIC_SECRET_KEY_PATH', nil)
      @secret_key = ENV.fetch('APPLE_MUSIC_SECRET_KEY', nil)
      @team_id = ENV.fetch('APPLE_MUSIC_TEAM_ID', nil)
      @music_id = ENV.fetch('APPLE_MUSIC_MUSIC_ID', nil)
      @rate_limiter = 0
      @token_expiration_time = TOKEN_EXPIRATION_TIME
      @storefront = ENV.fetch('APPLE_MUSIC_STOREFRONT') { DEFAULT_STOREFRONT }
    end

    def authentication_token
      private_key = OpenSSL::PKey::EC.new(apple_music_secret_key)
      JWT.encode(authentication_payload, private_key, ALGORITHM, kid: music_id)
    end

    private

    def apple_music_secret_key
      @secret_key ||= File.read(secret_key_path)
    end

    def authentication_payload(now = Time.now)
      {
        iss: team_id,
        iat: now.to_i,
        exp: now.to_i + token_expiration_time
      }
    end
  end
end
