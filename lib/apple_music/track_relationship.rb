# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/trackrelationship
  class TrackRelationship < Relationship
    self.resource = Track
  end
end
