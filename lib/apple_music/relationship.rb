# frozen_string_literal: true

module AppleMusic
  # https://developer.apple.com/documentation/applemusicapi/relationship
  class Relationship
    class << self
      attr_accessor :resource
    end

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
      return [] if resource.nil? || data.nil?

      data.map { |attrs| resource.new(attrs) }
    end

    def resource
      self.class.resource
    end
  end
end
