# frozen_string_literal: true

module AppleMusic
  class Artist < Resource
    # https://developer.apple.com/documentation/applemusicapi/artist/attributes
    class Attributes
      attr_reader :artwork, :editorial_notes, :genre_names, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) if props['artwork']
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @name = props['name'] # required
        @url = props['url'] # required
      end
    end

    self.attributes_model = self::Attributes
  end
end
