# frozen_string_literal: true

module AppleMusic
  class PlaylistResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/playlist
  class Playlist < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/playlist/attributes
    class Attributes
      attr_reader :artwork, :curator_name, :description, :last_modified_date,
                  :name, :play_params, :playlist_type, :url

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) if props['artwork']
        @curator_name = props['curatorName']
        @description = EditionalNotes.new(props['description']) if props['description']
        @last_modified_date = Date.parse(props['lastModifiedDate']) # required
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @playlist_type = props['playlistType'] # required
        @url = props['url'] # required
      end

      def user_shared?
        playlist_type == 'user-shared'
      end

      def editorial?
        playlist_type == 'editorial'
      end

      def external?
        playlist_type == 'external'
      end

      def personal_mix?
        playlist_type == 'personal-mix'
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/playlist/relationships
    class Relationships
      attr_reader :curator, :tracks

      def initialize(props = {})
        @curator = CuratorRelationship.new(props['curator']).data.first
        @tracks = TrackRelationship.new(props['tracks']).data
      end
    end

    class << self
      # e.g. AppleMusic::Playlist.find('pl.acc464c750b94302b8806e5fcbe56e17')
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists/#{id}", options)
        playlist_response = PlaylistResponse.new(response.body)
        new(playlist_response.data[0])
      end

      # e.g. AppleMusic::Playlist.list(ids: ['pl.acc464c750b94302b8806e5fcbe56e17', 'pl.97c6f95b0b884bedbcce117f9ea5d54b'])
      def list(**options)
        raise ParameterMissing, 'required parameter :ids is missing' unless options[:ids]

        get_collection_by_ids(options.delete(:ids), options)
      end

      # e.g. AppleMusic::Playlist.get_collection_by_ids(['pl.acc464c750b94302b8806e5fcbe56e17', 'pl.97c6f95b0b884bedbcce117f9ea5d54b'])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_playlists
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists", options.merge(ids: ids))
        playlist_response = PlaylistResponse.new(response.body)
        playlist_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::Playlist.get_relationship('pl.acc464c750b94302b8806e5fcbe56e17', :curator)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/playlists/#{id}/#{relationship_type}", options)
        playlist_response = PlaylistResponse.new(response.body)
        playlist_response.data.map { |props| Resource.build(props) }
      end

      # e.g. AppleMusic::Playlist.related_curator('pl.acc464c750b94302b8806e5fcbe56e17')
      def related_curator(id, **options)
        get_relationship(id, :curator, options).first
      end

      # e.g. AppleMusic::Playlist.related_tracks('pl.acc464c750b94302b8806e5fcbe56e17')
      def related_tracks(id, **options)
        get_relationship(id, :tracks, options)
      end
    end
  end
end
