# frozen_string_literal: true

module AppleMusic
  class StationResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/station
  class Station < Resource
    attr_reader :attributes

    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/station/attributes
    class Attributes
      attr_reader :artwork, :duration_in_millis, :editorial_notes,
                  :episode_number, :is_live, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) # required
        @duration_in_millis = props['durationInMillis']
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
        @episode_number = props['episodeNumber']
        @is_live = props['isLive'] # required
        @name = props['name'] # required
        @url = props['url'] # required
      end

      def live?
        is_live
      end
    end

    class << self
      # e.g. AppleMusic::Station.find('ra.985484166')
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_station
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/stations/#{id}", options)
        station_response = StationResponse.new(response.body)
        new(station_response.data[0])
      end

      # e.g. AppleMusic::Station.list(ids: ['ra.985484166', 'ra.1128062616'])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Station.get_collection_by_ids(['ra.985484166', 'ra.1128062616'])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_stations
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/stations", options.merge(ids: ids))
        station_response = StationResponse.new(response.body)
        station_response.data.map { |props| new(props) }
      end
    end
  end
end
