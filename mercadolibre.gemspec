# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercadolibre/version'

Gem::Specification.new do |spec|
  spec.name          = "mercadolibre"
  spec.version       = Mercadolibre::VERSION
  spec.authors       = ["Matias Hick"]
  spec.email         = ["unformatt@gmail.com"]
  spec.summary       = "Connect to Mercadolibre through Meli API"
  spec.description   = "Connect to Mercadolibre through Meli API"
  spec.homepage      = "https://github.com/unformattmh/mercadolibre"
  spec.license       = "MIT"

  spec.files         = Dir["LICENSE.md", "README.md", "CHANGELOG.md", "lib/**/*"]
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "rest-client", ">= 1.6.7"
end
