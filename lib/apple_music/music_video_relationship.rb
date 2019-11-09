# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/musicvideorelationship
  class MusicVideoRelationship < Relationship
    self.resource = MusicVideo
  end
end
