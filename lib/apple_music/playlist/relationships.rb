# frozen_string_literal: true

module AppleMusic
  class Playlist < Resource
    # https://developer.apple.com/documentation/applemusicapi/playlist/relationships
    class Relationships
      attr_reader :curator, :tracks

      def initialize(props = {})
        @curator = Relationship.new(props['curator']).data.first
        @tracks = Relationship.new(props['tracks']).data
      end
    end

    self.relationships_model = self::Relationships
  end
end
