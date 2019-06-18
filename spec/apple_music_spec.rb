# frozen_string_literal: true

RSpec.describe AppleMusic do
  it 'has a version number' do
    expect(AppleMusic::VERSION).not_to be nil
  end
end
