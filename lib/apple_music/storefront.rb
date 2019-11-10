# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/storefront
  class Storefront < Resource
    class << self
      # https://developer.apple.com/documentation/applemusicapi/get_a_storefront
      def find(id, **options)
        response = AppleMusic.get("storefronts/#{id}", options)
        Response.new(response.body).data.first
      end

      # https://developer.apple.com/documentation/applemusicapi/get_all_storefronts
      def list(**options)
        response = AppleMusic.get('storefronts', options)
        Response.new(response.body).data
      end

      def lookup(value, required: true)
        (value || AppleMusic.config.storefront).tap do |storefront|
          raise ParameterMissing, 'required parameter :storefront is missing' if required && !storefront
        end
      end

      def search(*)
        warn 'WARN: :storefronts is not searchable resource'
      end
    end
  end
end

require 'apple_music/storefront/attributes'
