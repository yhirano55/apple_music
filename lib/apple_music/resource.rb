# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/resource
  class Resource
    attr_reader :href, :id, :type

    def initialize(options = {})
      @href = options['href']
      @id = options['id']
      @type = options['type']
    end
  end
end
