# frozen_string_literal: true

module AppleMusic
  class Album < Resource
    # https://developer.apple.com/documentation/applemusicapi/album/relationships
    class Relationships
      attr_reader :artists, :genres, :tracks

      def initialize(props = {})
        @artists = Relationship.new(props['artists']).data
        @genres = Relationship.new(props['genres']).data
        @tracks = Relationship.new(props['tracks']).data
      end
    end

    self.relationships_model = self::Relationships
  end
end
