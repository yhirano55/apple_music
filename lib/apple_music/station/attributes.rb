# frozen_string_literal: true

module AppleMusic
  class Station < Resource
    # https://developer.apple.com/documentation/applemusicapi/station/attributes
    class Attributes
      attr_reader :artwork, :duration_in_millis, :editorial_notes,
                  :episode_number, :is_live, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) # required
        @duration_in_millis = props['durationInMillis']
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @episode_number = props['episodeNumber']
        @is_live = props['isLive'] # required
        @name = props['name'] # required
        @url = props['url'] # required
      end

      def live?
        is_live
      end
    end

    self.attributes_model = self::Attributes
  end
end
