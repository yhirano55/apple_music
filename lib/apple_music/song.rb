# frozen_string_literal: true

module AppleMusic
  class SongResponse < ResponseRoot; end

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

    class << self
      # e.g. AppleMusic::Song.find(900032829)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs/#{id}", options)
        song_response = SongResponse.new(response.body)
        new(song_response.data[0])
      end

      # e.g. AppleMusic::Song.list(ids: '203709340,201281527')
      # e.g. AppleMusic::Song.list(isrc: 'NLH851300057')
      def list(**options)
        if options[:ids]
          get_collection_by_ids(options.delete(:ids), options)
        elsif options[:isrc]
          get_collection_by_isrc(options.delete(:isrc), options)
        else
          raise ParameterMissing, 'required parameter :ids or :isrc is missing'
        end
      end

      # e.g. AppleMusic::Song.get_collection_by_ids([203709340, 201281527])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_id
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs", options.merge(ids: ids))
        song_response = SongResponse.new(response.body)
        song_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::Song.get_collection_by_isrc('NLH851300057')
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_isrc
      def get_collection_by_isrc(isrc, **options)
        isrc = isrc.is_a?(Array) ? isrc.join(',') : isrc
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs", options.merge('filter[isrc]': isrc))
        song_response = SongResponse.new(response.body)
        song_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::Song.get_relationship(900032829, :albums)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/songs/#{id}/#{relationship_type}", options)
        song_response = SongResponse.new(response.body)
        song_response.data.map { |props| Resource.build(props) }
      end

      # e.g. AppleMusic::Song.related_albums(900032829)
      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      # e.g. AppleMusic::Song.related_artists(900032829)
      def related_artists(id, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::Song.related_genres(900032829)
      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end

      # e.g. AppleMusic::Song.related_station(900032829)
      def related_station(id, **options)
        get_relationship(id, :station, options).first
      end
    end
  end
end
