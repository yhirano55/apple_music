# frozen_string_literal: true

module AppleMusic
  module Track
    class InvalidTypeError < StandardError; end

    def self.new(props = {})
      case props['type']
      when 'songs' then Song.new(props)
      when 'musicVideos' then MusicVideo.new(props)
      else raise InvalidTypeError, "#{props['type']} is invalid"
      end
    end
  end
end
