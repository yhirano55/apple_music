# frozen_string_literal: true

module AppleMusic
  class ChartResponse
    attr_reader :albums, :music_videos, :songs, :playlists

    def initialize(props = {})
      props ||= {}
      @albums = extract_chart_data(props['albums'])
      @music_videos = extract_chart_data(props['music-videos'])
      @songs = extract_chart_data(props['songs'])
      @playlists = extract_chart_data(props['playlists'])
    end

    private

    def extract_chart_data(collection)
      return [] unless collection

      collection.map { |props| Chart.new(props) }.first&.data
    end
  end

  class Chart
    attr_reader :chart, :data, :href, :name, :next

    def initialize(props = {})
      @chart = props['chart'] # required
      @data = Array(props['data']).map { |attrs| Resource.build(attrs) } # required
      @href = props['href'] # required
      @name = props['name'] # required
      @next = props['next']
    end

    class << self
      # e.g. AppleMusic::Chart.list(types: ['songs', 'albums', 'playlists'], genre: 20, limit: 30)
      # https://developer.apple.com/documentation/applemusicapi/get_catalog_charts
      def list(**options)
        raise ParameterMissing, 'required parameter :types is missing' unless options[:types]

        types = options[:types].is_a?(Array) ? options[:types].join(',') : options[:types]
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/charts", options.merge(types: types))
        ChartResponse.new(response.body['results'])
      end
    end
  end
end
