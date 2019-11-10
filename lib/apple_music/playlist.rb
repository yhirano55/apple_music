# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/playlist
  class Playlist < Resource
    class << self
      # e.g. AppleMusic::Playlist.find('pl.acc464c750b94302b8806e5fcbe56e17')
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Playlist.list(ids: ['pl.acc464c750b94302b8806e5fcbe56e17', 'pl.97c6f95b0b884bedbcce117f9ea5d54b'])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Playlist.get_collection_by_ids(['pl.acc464c750b94302b8806e5fcbe56e17', 'pl.97c6f95b0b884bedbcce117f9ea5d54b'])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_playlists
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Playlist.get_relationship('pl.acc464c750b94302b8806e5fcbe56e17', :curator)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Playlist.related_curator('pl.acc464c750b94302b8806e5fcbe56e17')
      def related_curator(id, **options)
        get_relationship(id, :curator, options).first
      end

      # e.g. AppleMusic::Playlist.related_tracks('pl.acc464c750b94302b8806e5fcbe56e17')
      def related_tracks(id, **options)
        get_relationship(id, :tracks, options)
      end
    end
  end
end

require 'apple_music/playlist/attributes'
require 'apple_music/playlist/relationships'
