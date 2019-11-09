# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/editorialnotes
  class EditionalNotes
    attr_reader :short, :standard

    def initialize(props = {})
      @short = props['short'] # required
      @standard = props['standard'] # required
    end
  end
end
