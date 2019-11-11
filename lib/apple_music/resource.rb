# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/resource
  class Resource
    class InvalidTypeError < StandardError; end

    RESOURCE_MAP = {
      'activities' => 'AppleMusic::Activity',
      'albums' => 'AppleMusic::Album',
      'apple-curators' => 'AppleMusic::AppleCurator',
      'artists' => 'AppleMusic::Artist',
      'curators' => 'AppleMusic::Curator',
      'genres' => 'AppleMusic::Genre',
      'music-videos' => 'AppleMusic::MusicVideo',
      'playlists' => 'AppleMusic::Playlist',
      'songs' => 'AppleMusic::Song',
      'stations' => 'AppleMusic::Station',
      'storefronts' => 'AppleMusic::Storefront'
    }.freeze

    class << self
      attr_accessor :attributes_model, :relationships_model

      def build(props)
        class_name = RESOURCE_MAP[props['type']] || raise(InvalidTypeError, "#{props['type']} type is undefined.")
        const_get(class_name).new(props)
      end
    end

    attr_reader :href, :id, :type, :attributes, :relationships

    def initialize(props = {})
      @href = props['href']
      @id = props['id']
      @type = props['type']
      @attributes = self.class.attributes_model.new(props['attributes']) if props['attributes']
      @relationships = self.class.relationships_model.new(props['relationships']) if props['relationships']
    end

    private

    def method_missing(name, *args, &block)
      if attributes.respond_to?(name)
        attributes.send(name, *args, &block)
      elsif relationships.respond_to?(name)
        relationships.send(name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      attributes.respond_to?(name, include_private) || relationships.respond_to?(name, include_private)
    end
  end
end
