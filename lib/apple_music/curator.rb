# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/curator
  class Curator < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/curator/attributes
    class Attributes
      attr_reader :artwork, :editorial_notes, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) # required
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
        @name = props['name'] # required
        @url = props['url'] # required
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/curator/relationships
    class Relationships
      def initialize(props = {})
        @playlists = PlaylistRelationship.new(props['playlists']).data
      end
    end
  end
end
