# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/preview
  class Preview < Resource
    attr_reader :artwork, :url

    def initialize(props = {})
      @artwork = Artwork.new(props['artwork']) if props['artwork']
      @url = props['url'] # required
    end
  end
end
