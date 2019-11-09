# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/artistrelationship
  class ArtistRelationship < Relationship
    self.resource = Artist
  end
end
