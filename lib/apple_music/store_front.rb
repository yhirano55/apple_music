# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/storefront
  class StoreFront < Resource
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
        (value || AppleMusic.config.store_front).tap do |store_front|
          raise ParameterMissing, 'required parameter :store_front is missing' if required && !store_front
        end
      end
    end
  end
end

require 'apple_music/store_front/attributes'
