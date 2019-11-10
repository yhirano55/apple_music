# frozen_string_literal: true

module AppleMusic
  class ArtistResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/artist
  class Artist < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/artist/attributes
    class Attributes
      attr_reader :editorial_notes, :genre_names, :name, :url

      def initialize(props = {})
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @name = props['name'] # required
        @url = props['url'] # required
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/artist/relationships
    class Relationships
      attr_reader :albums, :genres, :music_videos, :playlists, :station

      def initialize(props = {})
        props ||= {}

        @albums = AlbumRelationship.new(props['albums']).data
        @genres = GenreRelationship.new(props['genres']).data
        @music_videos = MusicVideoRelationship.new(props['musicVideos']).data
        @playlists = PlaylistRelationship.new(props['playlists']).data
        @station = StationRelationship.new(props['station']).data.first
      end
    end

    class << self
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists/#{id}", options)
        artist_response = ArtistResponse.new(response.body)
        new(artist_response.data[0])
      end

      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_artists
      def list(**options)
        raise(ParameterMissing, 'required parameter :ids is missing') unless options[:ids]

        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists", options)
        artist_response = ArtistResponse.new(response.body)
        artist_response.data.map { |props| new(props) }
      end

      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/artists/#{id}/#{relationship_type}", options)
        artist_response = ArtistResponse.new(response.body)
        artist_response.data.map { |props| Resource.build(props) }
      end

      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end

      def related_playlists(id, **options)
        get_relationship(id, :playlists, options)
      end

      def related_station(id, **options)
        get_relationship(id, :station, options).first
      end
    end
  end
end
