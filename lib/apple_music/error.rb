# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/error
  class Error
    attr_reader :code, :detail, :id, :source, :status, :title

    def initialize(props = {})
      @code = props['code'] # required
      @detail = props['detail']
      @id = props['id'] # required
      @source = Source.new(props['source']) if props['source']
      @status = props['status'] # required
      @title = props['title'] # required
    end

    # https://developer.apple.com/documentation/applemusicapi/error/source
    class Source
      attr_reader :parameter, :pointer

      def initialize(options = {})
        @parameter = options['parameter']
        @pointer = options['pointer']
      end
    end
  end
end
