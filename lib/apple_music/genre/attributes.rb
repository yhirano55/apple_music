# frozen_string_literal: true

module AppleMusic
  class Genre < Resource
    # https://developer.apple.com/documentation/applemusicapi/genre/attributes
    class Attributes
      attr_reader :name

      def initialize(props = {})
        @name = props['name'] # required
      end
    end

    self.attributes_model = self::Attributes
  end
end
