# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/relationship
  class Relationship
    attr_reader :data, :href, :meta, :next

    def initialize(props = {})
      props ||= {}

      @data = build_list(props['data'])
      @href = props['href']
      @meta = props['meta']
      @next = props['next']
    end

    private

    def build_list(data)
      Array(data).map { |attrs| Resource.build(attrs) }
    end
  end
end
