# frozen_string_literal: true

module AppleMusic
  class SearchResponse < Response
    def initialize(props = {})
      @results = SearchResult.new(props['results'])
      super
    end
  end

  module Search
    class << self
      # e.g. AppleMusic::Search.search(term: 'aaamyyy')
      # https://developer.apple.com/documentation/applemusicapi/search_for_catalog_resources
      def search(**options)
        options[:term] = format_term(options[:term]) if options[:term]
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/search", options)
        SearchResult.new(response.body['results'] || {})
      end

      # e.g. AppleMusic::Search.search_hints(term: 'aaamyyy')
      # https://developer.apple.com/documentation/applemusicapi/get_catalog_search_hints
      def search_hints(**options)
        options[:term] = format_term(options[:term]) if options[:term]
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/search/hints", options)
        response.body.dig('results', 'terms') || []
      end

      private

      def format_term(term)
        term.is_a?(Array) ? term.join('+') : term
      end
    end
  end
end
