# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/chart
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
        ChartResponse.new(response.body['results'] || {})
      end
    end
  end
end
