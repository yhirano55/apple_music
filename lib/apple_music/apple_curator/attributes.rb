# frozen_string_literal: true

module AppleMusic
  class AppleCurator < Resource
    # https://developer.apple.com/documentation/applemusicapi/applecurator/attributes
    class Attributes
      attr_reader :artwork, :editorial_notes, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) # required
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @name = props['name'] # required
        @url = props['url'] # required
      end
    end

    self.attributes_model = self::Attributes
  end
end
