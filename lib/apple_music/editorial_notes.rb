# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/editorialnotes
  class EditorialNotes
    attr_reader :short, :standard, :name, :tagline

    def initialize(props = {})
      @short = props['short'] # required
      @standard = props['standard'] # required
      @name = props['name']
      @tagline = props['tagline']
    end
  end
end
