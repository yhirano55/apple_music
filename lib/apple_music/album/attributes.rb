# frozen_string_literal: true

module AppleMusic
  class Album < Resource
    # https://developer.apple.com/documentation/applemusicapi/album/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :content_rating,
                  :copyright, :editorial_notes, :genre_names, :is_complete,
                  :is_single, :name, :play_params, :record_label, :release_date,
                  :track_count, :url, :is_mastered_for_itunes

      def initialize(props = {})
        @album_name = props['albumName'] # required
        @artist_name = props['artistName'] # required
        @artwork = Artwork.new(props['artwork']) if props['artwork']
        @content_rating = props['contentRating']
        @copyright = props['copyright']
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @is_complete = props['isComplete'] # required
        @is_single = props['isSingle'] # required
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @record_label = props['recordLabel'] # required
        @release_date = Date.parse(props['releaseDate']) # required
        @track_count = props['trackCount'] # required
        @url = props['url'] # required
        @is_mastered_for_itunes = props['isMasteredForItunes'] # required
      end

      def complete?
        is_complete
      end

      def single?
        is_single
      end

      def mastered_for_itunes?
        is_mastered_for_itunes
      end
    end

    self.attributes_model = self::Attributes
  end
end
