# frozen_string_literal: true

module AppleMusic
  class Artist < Resource
    # https://developer.apple.com/documentation/applemusicapi/artist/relationships
    class Relationships
      attr_reader :albums, :genres, :music_videos, :playlists, :station

      def initialize(props = {})
        @albums = Relationship.new(props['albums']).data
        @genres = Relationship.new(props['genres']).data
        @music_videos = Relationship.new(props['musicVideos']).data
        @playlists = Relationship.new(props['playlists']).data
        @station = Relationship.new(props['station']).data.first
      end
    end

    self.relationships_model = self::Relationships
  end
end
