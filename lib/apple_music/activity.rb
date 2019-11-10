# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/activity
  class Activity < Resource
    class << self
      # e.g. AppleMusic::Activity.find(976439514)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_activity
      def find(id, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/activities/#{id}", options)
        Response.new(response.body).data.first
      end

      # e.g. AppleMusic::Activity.list(ids: [976439514, 976439503])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Activity.get_collection_by_ids([976439514, 976439503])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_activities
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/activities", options.merge(ids: ids))
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Activity.get_relationship(976439514, :playlists)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_activity_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/activities/#{id}/#{relationship_type}", options)
        Response.new(response.body).data
      end

      # e.g. AppleMusic::Activity.related_playlists(976439514)
      def related_playlists(id, **options)
        get_relationship(id, :playlists, options)
      end
    end
  end
end

require 'apple_music/activity/attributes'
require 'apple_music/activity/relationships'
