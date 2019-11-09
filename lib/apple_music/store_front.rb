# frozen_string_literal: true

module AppleMusic
  class StoreFrontResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/storefront
  class StoreFront < Resource
    attr_reader :attributes

    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/storefront/attributes
    class Attributes
      attr_reader :default_language_tag, :name, :support_language_tags

      def initialize(props = {})
        @default_language_tag = props['defaultLanguageTag'] # required
        @name = props['name'] # required
        @support_language_tags = props['supportedLanguageTags'] # required
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

      def lookup(value, required: true)
        (value || AppleMusic.config.store_front).tap do |store_front|
          raise ParameterMissing, 'required parameter :store_front is missing' if required && !store_front
        end
      end
    end
  end
end
