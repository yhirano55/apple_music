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
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/search", options)
        SearchResult.new(response.body['results'] || {})
      end

      # e.g. AppleMusic::Search.search_hints(term: 'aaamyyy')
      # https://developer.apple.com/documentation/applemusicapi/get_catalog_search_hints
      def search_hints(**options)
        options[:term] = format_term(options[:term]) if options[:term]
        storefront = Storefront.lookup(options.delete(:storefront))
        response = AppleMusic.get("catalog/#{storefront}/search/hints", options)
        response.body.dig('results', 'terms') || []
      end

      private

      def format_term(term)
        term.is_a?(Array) ? term.join('+') : term
      end
    end
  end
end
