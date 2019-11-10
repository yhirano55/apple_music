# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/chartresponse
  class ChartResponse
    attr_reader :albums, :music_videos, :songs, :playlists

    def initialize(props = {})
      @albums       = build_chart(props['albums'])&.data || []
      @music_videos = build_chart(props['music-videos'])&.data || []
      @songs        = build_chart(props['songs'])&.data || []
      @playlists    = build_chart(props['playlists'])&.data || []
    end

    private

    def build_chart(resources)
      Array(resources).map { |props| Chart.new(props) }.first
    end
  end
end
