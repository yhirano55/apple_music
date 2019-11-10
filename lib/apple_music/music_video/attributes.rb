# frozen_string_literal: true

module AppleMusic
  class MusicVideo < Resource
    # https://developer.apple.com/documentation/applemusicapi/musicvideo/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :content_rating, :duration_in_millis,
                  :editorial_notes, :genre_names, :isrc, :name, :play_params, :previews,
                  :release_date, :track_number, :url, :video_sub_type, :has_hdr, :has_4k

      def initialize(props = {})
        @album_name = props['albumName']
        @artist_name = props['artistName'] # required
        @artwork = Artwork.new(props['artwork']) # required
        @content_rating = props['contentRating']
        @duration_in_millis = props['durationInMillis']
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @isrc = props['isrc'] # required
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @previews = Array(props['previews']).map { |attrs| Preview.new(attrs) } # required
        @release_date = Date.parse(props['releaseDate']) # required
        @track_number = props['trackNumber']
        @url = props['url'] # required
        @video_sub_type = props['videoSubType']
        @has_hdr = props['hasHDR'] # required
        @has_4k = props['has4K'] # required
      end

      def has_hdr?
        has_hdr
      end

      def has_4k?
        has_4k
      end
    end

    self.attributes_model = self::Attributes
  end
end
