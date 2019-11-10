# frozen_string_literal: true

module AppleMusic
  class CuratorResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/curator
  class Curator < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/curator/attributes
    class Attributes
      attr_reader :artwork, :editorial_notes, :name, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) # required
        @editorial_notes = EditionalNotes.new(props['editorialNotes']) if props['editorialNotes']
        @name = props['name'] # required
        @url = props['url'] # required
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/curator/relationships
    class Relationships
      def initialize(props = {})
        @playlists = PlaylistRelationship.new(props['playlists']).data
      end
    end

    class << self
      # e.g. AppleMusic::Curator.find(1107687517)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/curators/#{id}", options)
        curator_response = CuratorResponse.new(response.body)
        new(curator_response.data[0])
      end

      # e.g. AppleMusic::Curator.list(ids: [976439448, 1107687517])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Curator.get_collection_by_ids([976439448, 1107687517])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_curators
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/curators", options.merge(ids: ids))
        curator_response = CuratorResponse.new(response.body)
        curator_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::Curator.get_relationship(976439448, :playlists)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/curators/#{id}/#{relationship_type}", options)
        curator_response = CuratorResponse.new(response.body)
        curator_response.data.map { |props| Resource.build(props) }
      end

      # e.g. AppleMusic::Curator.related_playlists(976439448)
      def related_playlists(id, **options)
        get_relationship(id, :playlists, options)
      end
    end
  end
end
