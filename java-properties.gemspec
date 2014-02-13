# coding: utf-8
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'java-properties/version'

Gem::Specification.new do |spec|
  spec.name          = "java-properties"
  spec.version       = JavaProperties::VERSION.dup
  spec.authors       = ["Jonas Thiel"]
  spec.email         = ["jonas@thiel.io"]
  spec.summary       = %q{Loader and writer for *.properties files}
  spec.description   = %q{Tool for loading and writing Java properties files}
  spec.homepage      = "https://github.com/jnbt/java-properties"
  spec.license       = "MIT"

  spec.files = %w(LICENSE README.md Rakefile java-properties.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.test_files = Dir.glob("spec/**/*.rb")
  spec.test_files = Dir.glob("spec/fixtures/**/*.properties")

  spec.required_rubygems_version = '>= 1.3.5'
end