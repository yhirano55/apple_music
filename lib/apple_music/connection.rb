# frozen_string_literal: true

require 'faraday'
require 'faraday-http-cache'

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
      @client ||= Faraday.new(API_URI) do |conn|
        conn.response :json, content_type: /\bjson\z/
        conn.request :rate_limiter, interval: @config.rate_limiter if @config.rate_limiter&.positive?
        conn.use Faraday::HttpCache, store: @config.cache_store if @config.cache_store.present?
        conn.headers['Authorization'] = "Bearer #{config.authentication_token}"
      end
    end

    def method_missing(name, *args, &)
      if client.respond_to?(name)
        client.send(name, *args, &)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      client.respond_to?(name, include_private)
    end
  end
end
