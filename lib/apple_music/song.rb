# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/song
  class Song < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/song/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :composer_name,
                  :content_rating, :disc_number, :duration_in_millis,
                  :editorial_notes, :genre_names, :isrc, :movement_count,
                  :movement_name, :movement_number, :name, :play_params,
                  :previews, :release_date, :track_number, :url, :work_name

      def initialize(props = {})
        @album_name = props['albumName'] # required
        @artist_name = props['artistName'] # required
        @artwork = Artwork.new(props['artwork']) # required
        @composer_name = props['composerName']
        @content_rating = props['contentRating']
        @disc_number = props['discNumber'] # required
        @duration_in_millis = props['durationInMillis']
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @isrc = props['isrc'] # required
        @movement_count = props['movementCount']
        @movement_name = props['movementName']
        @movement_number = props['movementNumber']
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @previews = Array(props['previews']).map { |attrs| Preview.new(attrs) } # required
        @release_date = Date.parse(props['releaseDate']) # required
        @track_number = props['trackNumber'] # required
        @url = props['url'] # required
        @work_name = props['workName']
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/song/relationships
    class Relationships
      attr_reader :albums, :artists, :genres, :station

      def initialize(props = {})
        @albums = AlbumRelationship.new(props['albums']).data
        @artists = ArtistRelationship.new(props['artists']).data
        @genres = GenreRelationship.new(props['genres']).data
        @station = StationRelationship.new(props['station']).data.first
      end
    end
  end
end
