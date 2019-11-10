# frozen_string_literal: true

module AppleMusic
  class MusicVideoResponse < ResponseRoot; end

  # https://developer.apple.com/documentation/applemusicapi/musicvideo
  class MusicVideo < Resource
    def initialize(props = {})
      @attributes = Attributes.new(props['attributes']) if props['attributes']
      @relationships = Relationships.new(props['relationships']) if props['relationships']
      super
    end

    # https://developer.apple.com/documentation/applemusicapi/musicvideo/attributes
    class Attributes
      attr_reader :album_name, :artist_name, :artwork, :content_rating, :duration_in_millis,
                  :editorial_notes, :genre_names, :isrc, :name, :play_params, :previews,
                  :release_date, :track_number, :url, :video_sub_type, :has_hdr, :has_4k

      def initialize(props = {})
        @album_name = props['albumName']
        @artist_name = props['artistName'] # required
        @artwork = Artwork.new(props['artwork']) # required
        @content_rating = props['contentRating']
        @duration_in_millis = props['durationInMillis']
        @editorial_notes = EditorialNotes.new(props['editorialNotes']) if props['editorialNotes']
        @genre_names = props['genreNames'] # required
        @isrc = props['isrc'] # required
        @name = props['name'] # required
        @play_params = PlayParameters.new(props['playParams']) if props['playParams']
        @previews = Array(props['previews']).map { |attrs| Preview.new(attrs) } # required
        @release_date = Date.parse(props['releaseDate']) # required
        @track_number = props['trackNumber']
        @url = props['url'] # required
        @video_sub_type = props['videoSubType']
        @has_hdr = props['hasHDR'] # required
        @has_4k = props['has4K'] # required
      end

      def has_hdr?
        has_hdr
      end

      def has_4k?
        has_4k
      end
    end

    # https://developer.apple.com/documentation/applemusicapi/musicvideo/relationships
    class Relationships
      attr_reader :albums, :artists, :genres

      def initialize(props = {})
        @albums = AlbumRelationship.new(props['albums']).data
        @artists = ArtistRelationship.new(props['artists']).data
        @genres = GenreRelationship.new(props['genres']).data
      end
    end

    class << self
      # e.g. AppleMusic::MusicVideo.find(401135199)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video
      def find(id, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos/#{id}", options)
        music_video_response = MusicVideoResponse.new(response.body)
        new(music_video_response.data[0])
      end

      # e.g. AppleMusic::MusicVideo.list(ids: [401135199, 401147268])
      # e.g. AppleMusic::MusicVideo.list(isrc: 'GBDCE0900012')
      def list(**options)
        if options[:ids]
          get_collection_by_ids(options.delete(:ids), options)
        elsif options[:isrc]
          get_collection_by_isrc(options.delete(:isrc), options)
        else
          raise ParameterMissing, 'required parameter :ids or :isrc is missing'
        end
      end

      # e.g. AppleMusic::MusicVideo.get_collection_by_ids([401135199, 401147268])
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_id
      def get_collection_by_ids(ids, **options)
        ids = ids.is_a?(Array) ? ids.join(',') : ids
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos", options.merge(ids: ids))
        music_video_response = MusicVideoResponse.new(response.body)
        music_video_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::MusicVideo.get_collection_by_isrc('GBDCE0900012')
      # https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_isrc
      def get_collection_by_isrc(isrc, **options)
        isrc = isrc.is_a?(Array) ? isrc.join(',') : isrc
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos", options.merge('filter[isrc]': isrc))
        music_video_response = MusicVideoResponse.new(response.body)
        music_video_response.data.map { |props| new(props) }
      end

      # e.g. AppleMusic::MusicVideo.get_relationship(401135199, :albums)
      # https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video_s_relationship_directly_by_name
      def get_relationship(id, relationship_type, **options)
        store_front = StoreFront.lookup(options.delete(:store_front))
        response = AppleMusic.get("catalog/#{store_front}/music-videos/#{id}/#{relationship_type}", options)
        music_video_response = MusicVideoResponse.new(response.body)
        music_video_response.data.map { |props| Resource.build(props) }
      end

      # e.g. AppleMusic::MusicVideo.related_albums(401135199)
      def related_albums(id, **options)
        get_relationship(id, :albums, options)
      end

      # e.g. AppleMusic::MusicVideo.related_artists(401135199)
      def related_artists(id, **options)
        get_relationship(id, :artists, options)
      end

      # e.g. AppleMusic::MusicVideo.related_genres(401135199)
      def related_genres(id, **options)
        get_relationship(id, :genres, options)
      end
    end
  end
end
