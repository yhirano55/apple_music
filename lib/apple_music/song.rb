# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/song
  class Song < Resource
    class << self
      # e.g. AppleMusic::Song.find(900032829)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Song.list(ids: '203709340,201281527')
      # e.g. AppleMusic::Song.list(isrc: 'NLH851300057')
      def list(**options)
        if options[:ids]
          get_collection_by_ids(options.delete(:ids), options)
        elsif options[:isrc]
          get_collection_by_isrc(options.delete(:isrc), options)
        else
          raise ParameterMissing, 'required parameter :ids or :isrc is missing'
        end
      end

      # e.g. AppleMusic::Song.get_collection_by_ids([203709340, 201281527])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_id
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Song.get_collection_by_isrc('NLH851300057')
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_isrc
      def get_collection_by_isrc(isrc, **options)
        isrc = isrc.is_a?(Array) ? isrc.join(',') : isrc
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs", options.merge('filter[isrc]': isrc))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Song.get_relationship(900032829, :albums)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Song.related_albums(900032829)
      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      # e.g. AppleMusic::Song.related_artists(900032829)
      def related_artists(id, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::Song.related_genres(900032829)
      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end

      # e.g. AppleMusic::Song.related_station(900032829)
      def related_station(id, **options)
        get_relationship(id, :station, options).first
      end
    end
  end
end

require 'apple_music/song/attributes'
require 'apple_music/song/relationships'
