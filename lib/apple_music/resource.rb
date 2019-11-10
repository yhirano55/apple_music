# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/resource
  class Resource
    RESOURCE_MAP = {
      'albums' => :Album,
      'artists' => :Artist,
      'apple-curators' => :Curator,
      'genres' => :Genre,
      'musicVideos' => :MusicVideo,
      'playlists' => :Playlist,
      'songs' => :Song,
      'stations' => :Station,
      'storeFronts' => :StoreFront
    }.freeze

    def self.build(props)
      const_get("::AppleMusic::#{RESOURCE_MAP[props['type']]}").new(props)
    end

    attr_reader :href, :id, :type, :attributes, :relationships

    def initialize(props = {})
      props ||= {}
      @href = props['href']
      @id = props['id']
      @type = props['type']
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
