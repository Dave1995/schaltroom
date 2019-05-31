Gem::Specification.new do |spec|
  spec.name        = 'schaltroom'
  spec.version     = '0.0.0'
  spec.summary     = "Schaltroom"
  spec.description = "Schaltroom is the Client Gem for the Schaltroom configuration server"
  spec.authors     = ["David Erler"]
  spec.email       = 'daviderler1959@gmail.com'
  spec.files       = ["lib/schaltroom.rb"]
  spec.homepage    = 'https://rubygems.org/gems/schaltroom'
  spec.license     = ''

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'minitest-reporters'
end
