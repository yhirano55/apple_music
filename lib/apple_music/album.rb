# frozen_string_literal: true

module AppleMusic
  class AlbumResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/album
  class Album < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/album/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :content_rating,
                  :copyright, :editional_notes, :genre_names, :is_complete,
                  :is_single, :name, :play_params, :record_label, :release_date,
                  :track_count, :url, :is_mastered_for_itunes

      def initialize(props = {})
        @album_name = props['albumName'] # required
        @artist_name = props['artistName'] # required
        @artwork = Artwork.new(props['artwork']) if props['artwork']
        @content_rating = props['contentRating']
        @copyright = props['copyright']
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
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

    # https://developer.apple.com/documentation/applemusicapi/album/relationships
    class Relationships
      attr_reader :artists, :genres, :tracks

      def initialize(props = {})
        @artists = ArtistRelationship.new(props['artists']).data
        @genres = GenreRelationship.new(props['genres']).data
        @tracks = TrackRelationship.new(props['tracks']).data
      end
    end

    class << self
      # e.g. AppleMusic::Album.find(310730204)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums/#{id}", options)
        album_response = AlbumResponse.new(response.body)
        new(album_response.data[0])
      end

      # e.g. AppleMusic::Album.list(ids: [310730204, 19075891])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Album.get_collection_by_ids([310730204, 19075891])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_albums
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums", options.merge(ids: ids))
        album_response = AlbumResponse.new(response.body)
        album_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::Album.get_relationship(310730204, :artists)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/albums/#{id}/#{relationship_type}", options)
        album_response = AlbumResponse.new(response.body)
        album_response.data.map { |props| Resource.build(props) }
      end

      # e.g. AppleMusic::Album.related_artists(310730204)
      def related_artists(id:, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::Album.related_genres(310730204)
      def related_genres(id:, **options)
        get_relationship(id, :genres, options)
      end

      # e.g. AppleMusic::Album.related_tracks(310730204)
      def related_tracks(id:, **options)
        get_relationship(id, :tracks, options)
      end
    end
  end
end
