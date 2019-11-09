# frozen_string_literal: true

module AppleMusic
  class StoreFrontResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/storefront
  class StoreFront < Resource
    attr_reader :attributes

    def initialize(options = {})
      @attributes = Attributes.new(options['attributes'] || {})
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/storefront/attributes
    class Attributes
      attr_reader :default_language_tag, :name, :support_language_tags

      def initialize(options = {})
        @default_language_tag = options['defaultLanguageTag']
        @name = options['name']
        @support_language_tags = options['supportedLanguageTags']
      end
    end

    class << self
      # https://developer.apple.com/documentation/applemusicapi/get_a_storefront
      def find(id, **options)
        url = "storefronts/#{id}"
        response = AppleMusic.get(url, options)
        store_front_response = StoreFrontResponse.new(response.body)
        new(store_front_response.data[0])
      end

      # https://developer.apple.com/documentation/applemusicapi/get_all_storefronts
      def list(**options)
        url = 'storefronts'
        response = AppleMusic.get(url, options)
        store_front_response = StoreFrontResponse.new(response.body)
        store_front_response.data.map { |data| new(data) }
      end
    end
  end
end
