# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/album
  class Album < Resource
    class << self
      # e.g. AppleMusic::Album.find(310730204)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Album.list(ids: [310730204, 19075891])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Album.get_collection_by_ids([310730204, 19075891])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_albums
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Album.get_relationship(310730204, :artists)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Album.related_artists(310730204)
      def related_artists(id:, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::Album.related_genres(310730204)
      def related_genres(id:, **options)
        get_relationship(id, :genres, options)
      end

      # e.g. AppleMusic::Album.related_tracks(310730204)
      def related_tracks(id:, **options)
        get_relationship(id, :tracks, options)
      end
    end
  end
end

require 'apple_music/album/attributes'
require 'apple_music/album/relationships'
