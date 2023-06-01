# frozen_string_literal: true

require 'faraday'

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
        config.connection&.call(conn)
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
