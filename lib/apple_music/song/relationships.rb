# frozen_string_literal: true

module AppleMusic
  class Song < Resource
    # https://developer.apple.com/documentation/applemusicapi/song/relationships
    class Relationships
      attr_reader :albums, :artists, :genres, :station

      def initialize(props = {})
        @albums = Relationship.new(props['albums']).data
        @artists = Relationship.new(props['artists']).data
        @genres = Relationship.new(props['genres']).data
        @station = Relationship.new(props['station']).data.first
      end
    end

    self.relationships_model = self::Relationships
  end
end
