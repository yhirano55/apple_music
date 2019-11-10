# frozen_string_literal: true

module AppleMusic
  class Storefront < Resource
    # https://developer.apple.com/documentation/applemusicapi/storefront/attributes
    class Attributes
      attr_reader :default_language_tag, :name, :support_language_tags

      def initialize(props = {})
        @default_language_tag = props['defaultLanguageTag'] # required
        @name = props['name'] # required
        @support_language_tags = props['supportedLanguageTags'] # required
      end
    end

    self.attributes_model = self::Attributes
  end
end
