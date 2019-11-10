# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/curator
  class Curator < Resource
    class << self
      # e.g. AppleMusic::Curator.find(1107687517)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator
      def find(id, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/curators/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Curator.list(ids: [976439448, 1107687517])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Curator.get_collection_by_ids([976439448, 1107687517])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_curators
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/curators", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Curator.get_relationship(976439448, :playlists)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/curators/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Curator.related_playlists(976439448)
      def related_playlists(id, **options)
        get_relationship(id, :playlists, options)
      end

      def search(term, **options)
        AppleMusic.search(options.merge(term: term, types: :curators)).curators
      end
    end
  end
end

require 'apple_music/curator/attributes'
require 'apple_music/curator/relationships'
