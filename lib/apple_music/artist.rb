# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/artist
  class Artist < Resource
    class << self
      # e.g. AppleMusic::Artist.find(178834)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Artist.list(ids: [178834, 462006])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Artist.get_collection_by_ids([178834, 462006])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_artists
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Artist.get_relationship(178834, :albums)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Artist.related_albums(178834)
      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      # e.g. AppleMusic::Artist.related_genres(178834)
      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end

      # e.g. AppleMusic::Artist.related_playlists(178834)
      def related_playlists(id, **options)
        get_relationship(id, :playlists, options)
      end

      # e.g. AppleMusic::Artist.related_station(178834)
      def related_station(id, **options)
        get_relationship(id, :station, options).first
      end
    end
  end
end

require 'apple_music/artist/attributes'
require 'apple_music/artist/relationships'
