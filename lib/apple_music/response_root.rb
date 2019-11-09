# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/responseroot
  class ResponseRoot
    attr_reader :data, :errors, :href, :meta, :next, :results

    def initialize(options = {})
      @data = options['data']
      @errors = Array(options['errors']).map { |error| Error.new(error) }
      @href = options['href']
      @meta = options['meta']
      @next = options['next']
      @results = options['results']
      raise_api_error unless success?
    end

    private

    def raise_api_error
      raise ApiError, errors.map(&:detail).join(', ')
    end

    def success?
      errors.empty?
    end
  end
end
