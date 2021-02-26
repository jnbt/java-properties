# frozen_string_literal: true

require_relative 'lib/java-properties/version'

Gem::Specification.new do |spec|
  spec.name          = 'java-properties'
  spec.version       = JavaProperties::VERSION.dup
  spec.authors       = ['Jonas Thiel']
  spec.email         = ['jonas@thiel.io']
  spec.summary       = %q{Loader and writer for *.properties files}
  spec.description   = %q{Tool for loading and writing Java properties files}
  spec.homepage      = 'https://github.com/jnbt/java-properties'
  spec.license       = 'MIT'

  spec.files = %w(LICENSE README.md Rakefile java-properties.gemspec)
  spec.files += Dir.glob('lib/**/*.rb')
  spec.test_files = Dir.glob('spec/**/*.rb')
  spec.test_files = Dir.glob('spec/fixtures/**/*.properties')

  spec.required_rubygems_version = '>= 1.3.5'
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'inch', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'coveralls', '~> 0.8'
end
