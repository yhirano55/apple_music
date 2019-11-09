# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/musicvideo
  class MusicVideo < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

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

    # https://developer.apple.com/documentation/applemusicapi/musicvideo/relationships
    class Relationships
      attr_reader :albums, :artists, :genres

      def initialize(props = {})
        @albums = AlbumRelationship.new(props['albums']).data
        @artists = ArtistRelationship.new(props['artists']).data
        @genres = GenreRelationship.new(props['genres']).data
      end
    end
  end
end
