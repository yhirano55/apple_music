# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/artwork
  class Artwork
    attr_reader :bg_color, :height, :width,
                :text_color1, :text_color2, :text_color3,
                :text_color4, :url

    def initialize(props = {})
      @bg_color = props['bgColor']
      @height = props['height'] # required
      @width = props['width'] # required
      @text_color1 = props['textColor1']
      @text_color2 = props['textColor2']
      @text_color3 = props['textColor3']
      @text_color4 = props['textColor4']
      @url = props['url'] # required
    end

    def image_url(options = {})
      @image_url ||= begin
        width = options[:width] || self.width
        height = options[:height] || self.height
        size = options[:size] || "#{width}x#{height}"
        url.gsub('{w}x{h}', size)
      end
    end
  end
end
