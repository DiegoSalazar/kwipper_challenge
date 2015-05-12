# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kwipper/version'

Gem::Specification.new do |spec|
  spec.name          = "kwipper"
  spec.version       = Kwipper::VERSION
  spec.authors       = ["Diego Salazar"]
  spec.email         = ["diego@greyrobot.com"]
  spec.summary       = %q{Kwipper is the reference example app for the Kwipper Programming Challenge}
  spec.description   = %q{Kwipper is the reference example app for the Kwipper Programming Challenge to build an app and server from scratch.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pg"
  spec.add_dependency "mime-types"
  spec.add_dependency "rack"
  spec.add_dependency "colorize"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
end
