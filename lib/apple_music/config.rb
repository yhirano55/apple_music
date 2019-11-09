# frozen_string_literal: true

require 'faraday'
require 'jwt'
require 'openssl'

module AppleMusic
  class Config
    ALGORITHM = 'ES256'
    TOKEN_EXPIRATION_TIME = 60 * 60 * 24 # 1.day
    DEFAULT_STORE_FRONT = 'us'

    attr_accessor :secret_key_path, :team_id, :music_id,
                  :token_expiration_time, :adapter, :store_front

    def initialize
      @secret_key_path = ENV['APPLE_MUSIC_SECRET_KEY_PATH']
      @team_id = ENV['APPLE_MUSIC_TEAM_ID']
      @music_id = ENV['APPLE_MUSIC_MUSIC_ID']
      @token_expiration_time = TOKEN_EXPIRATION_TIME
      @adapter = Faraday.default_adapter
      @store_front = ENV.fetch('APPLE_MUSIC_STORE_FRONT') { DEFAULT_STORE_FRONT }
    end

    def authentication_token
      private_key = OpenSSL::PKey::EC.new(apple_music_secret_key)
      JWT.encode(authentication_payload, private_key, ALGORITHM, kid: music_id)
    end

    private

    def apple_music_secret_key
      @apple_music_secret_key ||= File.read(secret_key_path)
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
