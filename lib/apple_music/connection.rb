# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

require 'apple_music/config'

module AppleMusic
  class ApiError < StandardError; end
  class ParameterMissing < StandardError; end

  API_URI = 'https://api.music.apple.com/v1/'

  class << self
    def config
      @config ||= Config.new
    end

    def configure(&block)
      block.call(config)
    end

    private

    def client
      if auth_header_expired?
        @client = nil
        @authentication_token = nil
      end

      @client ||= Faraday.new(API_URI) do |conn|
        conn.response :json, content_type: /\bjson\z/
        conn.headers['Authorization'] = "Bearer #{authentication_token}"
        conn.adapter config.adapter
      end
    end

    def authentication_token
      @authentication_token ||= config.authentication_token
    end

    def auth_header_expired?
      return false if authentication_token.nil?

      @config.token_expired?(authentication_token)
    end

    def method_missing(name, *args, &block)
      if client.respond_to?(name)
        client.send(name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      client.respond_to?(name, include_private)
    end
  end
end
