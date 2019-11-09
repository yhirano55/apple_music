# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/playparameters
  class PlayParameters
    attr_reader :id, :kind

    def initialize(props = {})
      @id = props['id'] # required
      @kind = props['kind'] # required
    end
  end
end
