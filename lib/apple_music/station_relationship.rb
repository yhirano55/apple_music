# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/stationrelationship
  class StationRelationship < Relationship
    self.resource = Station
  end
end
