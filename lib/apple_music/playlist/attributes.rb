# frozen_string_literal: true

module AppleMusic
  class Playlist < Resource
    # https://developer.apple.com/documentation/applemusicapi/playlist/attributes
    class Attributes
      attr_reader :artwork, :curator_name, :description, :last_modified_date,
                  :name, :play_params, :playlist_type, :url, :is_chart

      def initialize(props = {})
        @artwork = Artwork.new(props['artwork']) if props['artwork']
        @curator_name = props['curatorName']
        @description = EditorialNotes.new(props['description']) if props['description']
        @last_modified_date = Date.parse(props['lastModifiedDate']) if props['lastModifiedDate']
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @playlist_type = props['playlistType'] # required
        @url = props['url'] # required
        @is_chart = props['isChart']
      end

      def chart?
        is_chart
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

    self.attributes_model = self::Attributes
  end
end
