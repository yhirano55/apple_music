# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/musicvideo
  class MusicVideo < Resource
    class << self
      # e.g. AppleMusic::MusicVideo.find(401135199)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::MusicVideo.list(ids: [401135199, 401147268])
      # e.g. AppleMusic::MusicVideo.list(isrc: 'GBDCE0900012')
      def list(**options)
        if options[:ids]
          get_collection_by_ids(options.delete(:ids), options)
        elsif options[:isrc]
          get_collection_by_isrc(options.delete(:isrc), options)
        else
          raise ParameterMissing, 'required parameter :ids or :isrc is missing'
        end
      end

      # e.g. AppleMusic::MusicVideo.get_collection_by_ids([401135199, 401147268])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_id
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::MusicVideo.get_collection_by_isrc('GBDCE0900012')
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_isrc
      def get_collection_by_isrc(isrc, **options)
        isrc = isrc.is_a?(Array) ? isrc.join(',') : isrc
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos", options.merge('filter[isrc]': isrc))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::MusicVideo.get_relationship(401135199, :albums)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::MusicVideo.related_albums(401135199)
      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      # e.g. AppleMusic::MusicVideo.related_artists(401135199)
      def related_artists(id, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::MusicVideo.related_genres(401135199)
      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end
    end
  end
end

require 'apple_music/music_video/attributes'
require 'apple_music/music_video/relationships'
