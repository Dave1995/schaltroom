# frozen_string_literal: true

require_relative 'lib/schaltroom/version'

Gem::Specification.new do |spec|
  spec.name        = 'schaltroom'
  spec.version     = Schaltroom::VERSION::STRING
  spec.summary     = 'schaltroom'
  spec.description = 'schaltroom is the Client Gem for the Schaltroom' \
                     'configuration server'
  spec.authors     = ['David Erler']
  spec.email       = 'daviderler1995@gmail.com'
  spec.files       = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.homepage    = 'https://rubygems.org/gems/schaltroom'
  spec.license     = 'MIT'

  spec.add_development_dependency 'bundler', '>=1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'mocha', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'

  spec.add_dependency 'zeitwerk', '~> 2.1', '>= 2.1.10'
end
