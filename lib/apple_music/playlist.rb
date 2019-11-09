# frozen_string_literal: true

module AppleMusic
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
  end
end
