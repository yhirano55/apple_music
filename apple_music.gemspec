# frozen_string_literal: true

lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apple_music/version'

Gem::Specification.new do |s|
  s.name          = 'apple_music'
  s.version       = AppleMusic::VERSION
  s.authors       = ['Yoshiyuki Hirano']
  s.email         = ['yhirano@me.com']

  s.homepage      = 'https://github.com/yhirano55/apple_music'
  s.summary       = 'Apple Music API Client Ruby'
  s.description   = s.summary
  s.license       = 'MIT'
  s.files         = Dir.chdir(File.expand_path('.', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features|images)/})
    end
  end

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'faraday', '>= 2.0'
  s.add_dependency 'faraday-http-cache'
  s.add_dependency 'faraday-rate_limiter'
  s.add_dependency 'jwt', '>= 2.2'

  s.metadata['rubygems_mfa_required'] = 'true'
end
