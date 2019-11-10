# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/genre
  class Genre < Resource
    class << self
      # e.g. AppleMusic::Genre.find(14)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_genre
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
      def find(id, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/genres/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Genre.list
      # e.g. AppleMusic::Genre.list(ids: [20, 34])
      # https://developer.apple.com/documentation/applemusicapi/get_catalog_top_charts_genres
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_genres
      def list(**options)
        if options[:ids]
          ids = options[:ids].is_a?(Array) ? options[:ids].join(',') : options[:ids]
          options[:ids] = ids
        end

        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/genres", options)
        Response.new(response.body).data
      end
    end
  end
end

require 'apple_music/genre/attributes'
