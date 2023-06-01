# frozen_string_literal: true

module AppleMusic
  class Album < Resource
    # https://developer.apple.com/documentation/applemusicapi/albums/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :content_rating,
                  :copyright, :editorial_notes, :genre_names, :is_complete,
                  :is_single, :name, :play_params, :record_label, :release_date,
                  :release_date_precision, :track_count, :url, :is_mastered_for_itunes,
                  :is_compilation, :upc

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
        @is_compilation = props['isCompilation']
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @record_label = props['recordLabel'] # required
        @release_date, @release_date_precision = begin # required
          [Date.parse(props['releaseDate']), 'day']
        rescue ArgumentError
          [Date.parse("#{props['releaseDate']}/01/01"), 'year']
        end
        @track_count = props['trackCount'] # required
        @url = props['url'] # required
        @is_mastered_for_itunes = props['isMasteredForItunes'] # required
        @upc = props['upc']
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

      def compilation?
        is_compilation
      end
    end

    self.attributes_model = self::Attributes
  end
end
