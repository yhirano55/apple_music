# frozen_string_literal: true

module AppleMusic
  class MusicVideo < Resource
    # https://developer.apple.com/documentation/applemusicapi/musicvideo/relationships
    class Relationships
      attr_reader :albums, :artists, :genres

      def initialize(props = {})
        @albums = Relationship.new(props['albums']).data
        @artists = Relationship.new(props['artists']).data
        @genres = Relationship.new(props['genres']).data
      end
    end

    self.relationships_model = self::Relationships
  end
end
