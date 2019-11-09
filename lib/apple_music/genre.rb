# frozen_string_literal: true

module AppleMusic
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
  end
end
