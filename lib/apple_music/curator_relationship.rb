# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/curatorrelationship
  class CuratorRelationship < Relationship
    self.resource = Curator
  end
end
