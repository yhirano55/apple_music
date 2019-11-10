# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/responseroot
  class Response
    attr_reader :data, :errors, :href, :meta, :next, :results

    def initialize(props = {})
      props ||= {}
      @data = Array(props['data']).map { |attrs| Resource.build(attrs) }
      @errors = Array(props['errors']).map { |attrs| Error.new(attrs) }
      @href = props['href']
      @meta = props['meta']
      @next = props['next']
      @results = props['results']
      raise_api_error unless success?
    end

    private

    def raise_api_error
      raise ApiError, errors.map(&:title).join(', ')
    end

    def success?
      errors.empty?
    end
  end
end
