# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/playlistrelationship
  class PlaylistRelationship < Relationship
    self.resource = Playlist
  end
end
