# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/albumrelationship
  class AlbumRelationship < Relationship
    self.resource = Album
  end
end
