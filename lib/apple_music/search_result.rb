# frozen_string_literal: true

module AppleMusic
  class SearchResult
    attr_reader :activities, :albums, :apple_curators, :artists,
                :curators, :music_videos, :playlists, :songs, :stations

    def initialize(props = {})
      @activities = Relationship.new(props['activities']).data
      @albums = Relationship.new(props['albums']).data
      @apple_curators = Relationship.new(props['apple-curators']).data
      @artists = Relationship.new(props['artists']).data
      @curators = Relationship.new(props['curators']).data
      @music_videos = Relationship.new(props['music-videos']).data
      @playlists = Relationship.new(props['playlists']).data
      @songs = Relationship.new(props['songs']).data
      @stations = Relationship.new(props['stations']).data
    end
  end
end
