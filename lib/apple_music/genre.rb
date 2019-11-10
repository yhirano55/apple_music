# frozen_string_literal: true

module AppleMusic
  class GenreResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/genre
  class Genre < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/genre/attributes
    class Attributes
      attr_reader :name

      def initialize(props = {})
        @name = props['name'] # required
      end
    end

    class << self
      # e.g. AppleMusic::Genre.find(14)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_genre
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/genres/#{id}", options)
        genre_response = GenreResponse.new(response.body)
        new(genre_response.data[0])
      end

      # e.g. AppleMusic::Genre.list
      # e.g. AppleMusic::Genre.list(ids: [20, 34])
      # https://developer.apple.com/documentation/applemusicapi/get_catalog_top_charts_genres
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_genres
      def list(**options)
        if options[:ids]
          ids = options[:ids].is_a?(Array) ? options[:ids].join(',') : options[:ids]
          options[:ids] = ids
        end

        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/genres", options)
        genre_response = GenreResponse.new(response.body)
        genre_response.data.map { |props| new(props) }
      end
    end
  end
end
