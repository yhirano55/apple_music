# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/station
  class Station < Resource
    class << self
      # e.g. AppleMusic::Station.find('ra.985484166')
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_station
      def find(id, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/stations/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Station.list(ids: ['ra.985484166', 'ra.1128062616'])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Station.get_collection_by_ids(['ra.985484166', 'ra.1128062616'])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_stations
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/stations", options.merge(ids: ids))
        Response.new(response.body).data
      end

      def search(term, **options)
        AppleMusic.search(options.merge(term: term, types: :stations)).stations
      end
    end
  end
end

require 'apple_music/station/attributes'
