# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/error
  class Error
    attr_reader :code, :detail, :id, :source, :status, :title

    def initialize(options = {})
      @code = options['code']
      @detail = options['detail']
      @id = options['id']
      @source = Source.new(options['source'] || {})
      @status = options['status']
      @title = options['title']
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
