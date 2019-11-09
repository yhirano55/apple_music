# frozen_string_literal: true

module AppleMusic
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
  end
end
