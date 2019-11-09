# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/genrerelationship
  class GenreRelationship < Relationship
    self.resource = Genre
  end
end
